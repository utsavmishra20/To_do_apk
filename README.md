# todo_app

# Flutter To-Do List App ✅

A simple To-Do application built with Flutter where users can add, update, mark as complete, and delete tasks. Tasks are stored locally so they remain after app restarts.

## Steps to Run
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/flutter-todo-app.git
2. Navigate into the project:
   ```bash
   cd flutter-todo-app
3. Install dependencies:
   ```bash
   flutter pub get
4. Run the app:
   ```bash
   flutter run


State Management:-

This project uses Provider for state management.
It helps in efficiently updating the UI when tasks are added, edited, completed, or deleted, while keeping the business logic separated from the widget tree.

Bonus feature implementation:

I have also implemented a bonus feature for task due dates. To do this, I inserted an extra variable named dueDate into the task class. I also modified the "add task" and "task detail" pages to allow for adding and modifying due dates.
