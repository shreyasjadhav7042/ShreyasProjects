# 🎭 Emotion Detection using Machine Learning

An Emotion Detection web application built using **Natural Language Processing (NLP)** and **Machine Learning**. The application predicts the emotion expressed in a given text and displays the prediction confidence through an interactive **Streamlit** interface.

---

## 📌 Features

- 📝 Detects emotions from user-entered text
- 🧹 Text preprocessing and cleaning
- 📚 Feature extraction using:
  - Bag of Words (BoW)
  - TF-IDF Vectorizer
- 🤖 Machine Learning models:
  - Multinomial Naive Bayes
  - Logistic Regression
- 📊 Displays prediction confidence
- 🌐 Interactive web application using Streamlit

---

## 🛠️ Tech Stack

- Python
- Pandas
- NumPy
- Scikit-learn
- NLTK
- Streamlit
- Joblib

---

## 🔄 Machine Learning Pipeline

1. Data Collection
2. Text Preprocessing
3. Label Encoding
4. Feature Extraction (BoW & TF-IDF)
5. Model Training
6. Model Evaluation
7. Model Deployment using Streamlit

---

## 🏆 Model Performance

| Feature Extraction | Algorithm | Accuracy |
|-------------------|-----------|----------|
| Bag of Words | Multinomial Naive Bayes | Compared |
| Bag of Words | Logistic Regression | Compared |
| TF-IDF | Multinomial Naive Bayes | Compared |
| **TF-IDF** | **Logistic Regression** | **86.46% ✅** |

**Best Performing Model**
- Algorithm: Logistic Regression
- Vectorizer: TF-IDF
- Accuracy: **86.46%**

---

## 📂 Project Structure

```
emotions_prediction_model/
│── app.py
│── text_classifier.ipynb
│── logistic_model.pkl
│── tfidf_vectorizer.pkl
│── label_encoder.pkl
│── README.md
```

---

## ▶️ Run the Project

Clone the repository:

```bash
git clone https://github.com/shreyasjadhav7042/ShreyasProjects.git
```

Navigate to the project folder:

```bash
cd emotions_prediction_model
```

Install dependencies:

```bash
pip install -r requirements.txt
```

Run the Streamlit app:

```bash
streamlit run app.py
```

---

## 📸 Project Preview

### Home Page

_Add your homepage screenshot here._

### Prediction Example

_Add your prediction screenshot here._

---

## 👨‍💻 Developed By

**Shreyas Jadhav**

🎓 TYBSc Data Science Student

GitHub: https://github.com/shreyasjadhav7042

---

## ⭐ If you like this project

Please consider giving this repository a **Star ⭐**.
