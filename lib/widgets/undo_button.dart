import 'package:flutter/material.dart';
import '../services/undo_service.dart';

/// Senior Architect Undo Button
/// Reactively enables/disables based on history availability.
class UndoButton extends StatelessWidget {
  const UndoButton({
    super.key,
    required this.onUndo,
  });

  final Function(UndoAction) onUndo;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: UndoService(),
      builder: (context, _) {
        final bool canUndo = UndoService().canUndo;
        
        return IconButton(
          icon: Icon(
            Icons.undo_rounded,
            color: canUndo 
                ? Theme.of(context).colorScheme.primary 
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
          onPressed: canUndo ? () => _performUndo(context) : null,
          tooltip: 'Undo',
        );
      },
    );
  }

  void _performUndo(BuildContext context) async {
    final action = await UndoService().undo();
    if (action != null) {
      onUndo(action);
      
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Last action undone: ${action.type.toUpperCase()}'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
