import pandas as pd
from transformers import GPT2Tokenizer

# Load the CSV data
data = pd.read_csv("netflix_userbase.csv")

# Drop rows with missing values
data.dropna(inplace=True)

# Remove unnecessary columns
columns_to_keep = ["User ID", "Country", "Age", "Gender", "Plan Duration"]
data = data[columns_to_keep]

# Convert categorical variables to appropriate data types
data["Country"] = data["Country"].astype("category")
data["Gender"] = data["Gender"].astype("category")

# Combine relevant columns into a single text column
data["text"] = data[["User ID", "Country", "Age", "Gender", "Plan Duration"]].apply(
    lambda row: " ".join(map(str, row)), axis=1
)

# Load GPT-2 tokenizer
tokenizer = GPT2Tokenizer.from_pretrained("gpt2")

# Tokenize the text data and add special tokens
data["tokenized_text"] = data["text"].apply(
    lambda text: tokenizer.encode(text, add_special_tokens=True)
)
