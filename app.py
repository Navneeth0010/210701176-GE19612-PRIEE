from flask import Flask, request, jsonify
import joblib
import logging

app = Flask(__name__)

# Set up logging
logging.basicConfig(level=logging.DEBUG)

# Load the trained model
def load_model():
    try:
        model = joblib.load('crop_recommendation_model.joblib')
        logging.info("Model loaded successfully.")
        return model
    except Exception as e:
        logging.error(f"Error loading model: {e}")
        return None

# Make a prediction
def predict(model, input_data):
    try:
        input_features = [list(input_data.values())]
        logging.debug(f"Input features: {input_features}")
        prediction = model.predict(input_features)
        logging.info(f"Prediction made successfully: {prediction[0]}")
        return prediction[0]
    except Exception as e:
        logging.error(f"Error making prediction: {e}")
        return None

@app.route('/predict', methods=['POST'])
def predict_crop():
    input_data = request.get_json()  # Get the JSON data from the request
    logging.debug(f"Received input data: {input_data}")
    
    if not input_data:
        logging.error("No input data provided")
        return jsonify({'error': 'No input data provided'}), 400

    model = load_model()
    if model is None:
        logging.error("Failed to load model")
        return jsonify({'error': 'Failed to load model'}), 500

    prediction = predict(model, input_data)
    if prediction is None:
        logging.error("Failed to predict crop")
        return jsonify({'error': 'Failed to predict crop'}), 500

    return jsonify({'crop': prediction})

if __name__ == '__main__':
    app.run(host='192.168.1.5', port=3000)
