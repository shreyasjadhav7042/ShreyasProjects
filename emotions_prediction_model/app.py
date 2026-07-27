import streamlit as st
import joblib

# ---------------- Page Configuration ----------------
st.set_page_config(
    page_title="Emotion Detection",
    page_icon="🎭",
    layout="wide"
)

# ---------------- Load Model ----------------
model = joblib.load("logistic_model.pkl")
vectorizer = joblib.load("tfidf_vectorizer.pkl")
le = joblib.load("label_encoder.pkl")

# ---------------- Title ----------------
st.markdown(
    "<h1 style='text-align:center;'>🎭 Emotion Detection</h1>",
    unsafe_allow_html=True
)

# ---------------- Sidebar ----------------
st.sidebar.title("📋 Model Information")
st.sidebar.write("🤖 **Algorithm:** Logistic Regression")
st.sidebar.write("🎯 **Accuracy:** 86.46%")
st.sidebar.write("📚 **Vectorizer:** TF-IDF")
st.sidebar.write("🎭 **Task:** Emotion Detection")

# ---------------- Input ----------------
text = st.text_area("Enter the Text:")

# ---------------- Prediction ----------------
if st.button("🔍 Predict"):

    if text.strip() == "":
        st.warning("⚠️ Please enter some text.")

    else:
        text_vector = vectorizer.transform([text])

        prediction = model.predict(text_vector)
        emotion = le.inverse_transform(prediction)

        probs = model.predict_proba(text_vector)[0]
        confidence = max(probs)

        st.success(
            f"🎭 **Predicted Emotion:** {emotion[0].title()}\n\n"
            f"📈 **Confidence:** {confidence:.2%}"
        )

        st.subheader("📊 Prediction Confidence")

        emotion_names = le.classes_

        for emotion_name, prob in zip(emotion_names, probs):
            st.write(f"**{emotion_name.title()}**")
            st.progress(float(prob))
            st.caption(f"{prob:.2%}")

# ---------------- Footer ----------------
st.markdown("---")

st.markdown(
    """
    <div style='text-align:center; color:gray;'>
        👨‍💻 <b>Developed by Shreyas Jadhav</b><br>
        🎓 TYBSc Data Science<br>
        📅 2026
    </div>
    """,
    unsafe_allow_html=True
)