# 💰 Expense Tracker with AI Receipt Scanning & Insights

A Flutter-based smart expense tracking application with AI-powered receipt scanning and spending insights.

---

## 🚀 Features

- Add / edit / delete expenses
- Categorize spending
- AI receipt scanning using Gemini API
- Automatic expense extraction from images
- Spending insights and analytics
- Offline local database support

---

## 🤖 AI Features

- Scan receipts using gallery
- Extract merchant, amount, date automatically
- AI-generated spending summaries
- Smart categorization of expenses

---

## 🏗️ Tech Stack

- Flutter
- Dart
- BLoC 
- SQLite (Local DB)
- Google Gemini API
- Image Picker

---

## 📱 App Modules

- Dashboard
- Add Expense
- Expense List
- Edit Expense
- Receipt Scanner
- AI Insights Screen
- Review Screen

---

## 📂 Project Structure

lib/
├── core/
│   ├── database/
│   ├── services/
│   ├── theme/
│   └── utils/
│
├── features/
│   └── expense/
│       ├── data/
│       ├── presentation/
│       │   ├── bloc/
│       │   └── screens/
│
├── main.dart

---

## ⚙️ Setup Instructions

### 1. Clone repo
```bash
git clone https://github.com/your-username/expense_tracker.git
