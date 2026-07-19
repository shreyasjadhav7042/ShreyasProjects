import streamlit as st
import joblib
import numpy as np

#Load model and scaler
model = joblib.load("decision_tree_model.pkl")
scaler = joblib.load("scaler.pkl")

#Page configuration
st.set_page_config(
    page_title="Diabetes Prediction",
    page_icon="🩺",
    layout='centered'
)

#Title
st.title("🩺 Diabetes Prediction System")
st.write("Enter the patient's health information below to predict whether they are diabetic.")

st.markdown("---")

#user inputs
pregnancies = st.number_input("Pregnencies", min_value=0, max_value=20)
glucose = st.number_input("Glucose", min_value=0, max_value=300)
blood_pressure = st.number_input("Blood Pressure", min_value=0)
skin_thickness = st.number_input("Skin Thickness", min_value=0, max_value=100)
insulin = st.number_input("Insulin", min_value=0, max_value=900)
bmi = st.number_input("BMI", min_value=0.0, max_value=70.0)
dpf = st.number_input("Diabetes Pedigree Function", min_value=0.0, max_value=3.0)
age = st.number_input("Age", min_value=1, max_value=120)

st.markdown("---")

#Prediction Button
if st.button("Predict"):

    data = np.array([[
        pregnancies,
        glucose,
        blood_pressure,
        skin_thickness,
        insulin,
        bmi,
        dpf,
        age
    ]])

    #scale input
    data_scaled = scaler.transform(data)

    #prediction
    prediction = model.predict(data_scaled)[0]

    # Probability (Decision Tree supports predict_proba)
    probability = model.predict_proba(data_scaled)

    st.subheader("Prediction Result")

    if prediction == 1:
        st.error("⚠️ The patient is likely Diabetic.")
    else:
        st.success("✅ The patient is Not Diabetic.")

    st.write(f"Probability of Not Diabetic: {probability[0][0]*100:.2f}%")
    st.write(f"Probability of Diabetic: {probability[0][1]*100:.2f}%")
    
st.markdown("---")

st.sidebar.title("About")
st.sidebar.info(
    """
    This application predicts whether a person is likely to have diabetes
    using a Decision Tree machine learning model.
    """
)
st.sidebar.success("Model Accuracy: 76.62%")

st.caption("Developed using Streamlit and Scikit-learn")
