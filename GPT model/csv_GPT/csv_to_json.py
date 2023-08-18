import pandas as pd
import json

# Load the CSV data
data = pd.read_csv("netflix_userbase.csv")  # Replace with your CSV file path

# List of column names
column_names = [
    "User ID", "Subscription Type", "Monthly Revenue", "Join Date",
    "Last Payment Date", "Country", "Age", "Gender", "Device", "Plan Duration"
]

# Initialize the prompt and completion pairs list
prompt_completion_pairs = []

# Generate prompt and completion pairs
for _, row in data.iterrows():
    prompt = f"Write a summary of User {row['User ID']}"
    completion = f"User ID: {row['User ID']}, Subscription Type: {row['Subscription Type']}, Monthly Revenue: {row['Monthly Revenue']}, Join Date: {row['Join Date']}, Last Payment Date: {row['Last Payment Date']}, Country: {row['Country']}, Age: {row['Age']}, Gender: {row['Gender']}, Device: {row['Device']}, Plan Duration: {row['Plan Duration']}"
    
    prompt_completion_pairs.append({"prompt": prompt, "completion": completion})

# Export prompt and completion pairs to a JSON file
with open("prompt_completion_pairs.json", "w") as json_file:
    json.dump(prompt_completion_pairs, json_file, indent=4)

print("Prompt and completion pairs exported to 'prompt_completion_pairs.json'")
