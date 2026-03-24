Welcome to OtakuSen.

## 🛠 Setup & Installation

If you want to run OtakuSen locally, follow these steps.

### 1. Prerequisites
Make sure you have these installed on your machine:
* **Ruby 3.4.x** * **PostgreSQL** (The app won't start without it!)
* **Bun** (We use this for the fast JS/CSS bundling)

### 2. Get the Code
```bash
git clone https://github.com/IntrovertInsaan/OtakuSen.git
cd OtakuSen
```

### 3. Install Dependencies
Grab both the Ruby gems and the JS packages:
```bash
bundle install
bun install
```

### 4. Database Setup
First, make sure your Postgres service is actually running. Then, run this to create and seed your database:
```bash
bin/rails db:prepare
```
*Note: If you're on a Mac and see a connection error, try `brew services start postgresql` first.*

### 5. Fire it up
Don't just use `rails s`. Use the dev script to make sure the Three.js assets and CSS watchers run too:
```bash
bin/dev
```
Now just head over to `http://localhost:3000` and you're good to go.

---
