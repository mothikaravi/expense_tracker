# 💰 Expense Tracker with AI Receipt Scanning & Insights

A Flutter-based smart expense tracking application with AI-powered receipt scanning and spending insights.

---
# 💰 Expense Tracker with AI Receipt Scanning & Insights

![Flutter](https://img.shields.io/badge/Flutter-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-blue?logo=dart)
![BLoC](https://img.shields.io/badge/State%20Management-BLoC-orange)
![SQLite](https://img.shields.io/badge/Database-SQLite-green)
![AI](https://img.shields.io/badge/AI-Gemini%20API-purple)

## 🚀 Features

- Add / edit / delete expenses
- Categorize spending
- AI receipt scanning using Gemini API
- Automatic expense extraction from images
- Spending insights and analytics
- Offline local database support

---

## 📸 Screenshots

### 📊 Dashboard
![Dashboard](assets/screenshots/DashboardDarkTheme.jpeg)
![Dashboard](assets/screenshots/DashBoardLightTheme.jpeg)

### ➕ Add Expense
![Add Expense](assets/screenshots/AddExpenseManually.jpeg)

### 📷 Receipt Scanner
![Scanner](assets/screenshots/ReceiptScanner.jpeg)

### 📷 Review Receipt 
![Review](assets/screenshots/ReviewReceipt.jpeg)

### 📷 Expense History
![Expense History](assets/screenshots/ExpenseHistory.jpeg)
![Expense History](assets/screenshots/ExpenseHistory2.jpeg)


### 🤖 AI Insights
![Insights](assets/screenshots/AIInsights.jpeg)

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
