from openai import OpenAI
import os
from pathlib import Path
from PIL import Image
import io


# Initialize OpenAI client with your API key

# Function to enhance the clarity of the input image using DALL-E 2 API
def generate_clearer_image(input_image_path, output_folder):
    # image_data = open(input_image_path, 'rb')
    # Open the image using PIL and convert it to 'RGBA'
    with Image.open(input_image_path) as img:
        rgba_image = img.convert('RGBA')
        
        # Save the converted image to a bytes buffer
        img_byte_arr = io.BytesIO()
        rgba_image.save(img_byte_arr, format='PNG')
        img_byte_arr = img_byte_arr.getvalue()
    
    client = OpenAI()
    
    # Request the image editing
    response = client.images.edit(
        model="dall-e-2",
        image = img_byte_arr,
        prompt="Upconvert the image by a factor of 4. The output image should look exactly like the input image but with a higher resolution. The output image should have a resolution of 512x512.",
        n=1,
        size="512x512"
    )

    # Get the URL of the generated image
    image_url = response.data[0].url
    
    # Download and save the generated image to the output folder
    output_image_path = output_folder / (input_image_path.stem + input_image_path.suffix)
    # Assuming you have a function `download_image` to download and save the image from `image_url`
    download_image(image_url, output_image_path)
    
    # print output image shape
    with Image.open(output_image_path) as img:
        print(f"Output image shape: {img.size}")

    return output_image_path

def download_image(image_url, output_path):
    import requests
    response = requests.get(image_url)
    if response.status_code == 200:
        with open(output_path, 'wb') as f:
            f.write(response.content)
    else:
        print(f"Error downloading image: {response.status_code}")

# Placeholder for the input folder path
input_folder_path = Path("/Users/cheffbcookin/Desktop/EC520/AI-Image_Processing_Tasks/UpconvertingTask/MatlabDecimated")

# Output folder
output_folder_path = input_folder_path.parent / (input_folder_path.name + "_dalle2_upconverted")
os.makedirs(output_folder_path, exist_ok=True)

# Process each image in the input folder
for image_file in input_folder_path.glob('*'):
    print(f"Processing {image_file.name}")
    generated_image_path = generate_clearer_image(image_file, output_folder_path)
    print(f"Generated image saved to {generated_image_path}")
