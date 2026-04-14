# GPSC Study App

A comprehensive Flutter application designed to help aspirants prepare for the GPSC (Gujarat Public Service Commission) exams. This app provides detailed study material, mock tests, and quiz questions for various subjects including History, Geography, and Polity.

## Features

- **History**: Detailed sections on Ancient, Medieval, and Modern history of India and Gujarat.
- **Geography**: (Coming Soon)
- **Polity**: (Coming Soon)
- **Quizzes**: Daily quizzes and mock tests to track your progress.
- **Clean Architecture**: Organized codebase for better maintainability and scalability.
- **Performance Optimized**: Uses data-driven UI and lazy-loading lists for a smooth experience.

## History Page Organization

The History page is organized into two main sections:

### 1. History of Gujarat
Explore the rich heritage of Gujarat:
- **Pre-Historic Gujarat**: Stone Age discoveries and early human settlements.
- **Lothal & Dholavira**: Maritime hub of Lothal and UNESCO site Dholavira.
- **Medieval Gujarat**: Golden Age of Solankis and Gujarat Sultanate.
- **Regional Kingdoms of Gujarat**: Major local dynasties and Vaghela dynasty.
- **British Rule in Gujarat**: Surat factory, cotton boom and industrialization.
- **Important Personalities of Gujarat**: Visionaries who shaped Gujarat and India.
- **Freedom Movement in Gujarat**: Satyagrahas, Dandi March, and role of Patel and Gandhi.
- **Culture & Heritage of Gujarat**: UNESCO sites, vibrant fairs, and folk dances.

### 2. History of India
Comprehensive coverage of Indian history:
- **Ancient History**: Indus Valley Civilization, Vedic Period, Mahajanapadas, Maurya Empire, Gupta Empire, and more.
- **Medieval History**: Delhi Sultanate, Mughal Empire, Vijayanagar, Bahmani, Maratha Empire, and Bhakti & Sufi Movements.
- **Modern History**: Advent of Europeans, British Expansion, Revolt of 1857, Socio-Religious Reforms, INC, Gandhian Era, and the road to Independence.

## Technical Architecture

The project follows clean architecture principles:
- **Models**: Data structures defined in `lib/models`.
- **Data**: Static data and content providers in `lib/data`.
- **UI**: Reusable widgets and modular pages in `lib/pages` and `lib/widgets`.

## Performance Optimization

- **ListView.builder**: Used for lazy-loading and efficient rendering of large lists.
- **Flattened Data Lists**: Pre-calculated lists for faster indexing and layout.
- **Custom Widgets**: Highly optimized widgets for a consistent and responsive UI.

## Getting Started

To run this project:
1. Ensure you have Flutter installed.
2. Clone the repository.
3. Run `flutter pub get`.
4. Run `flutter run`.
