# import os
# from openai import OpenAI
# from PIL import Image
# import io
# import requests

# # Initialize OpenAI client with your API key
# client = OpenAI()

# def generate_denoised_image(input_image_path, output_folder):
#     with Image.open(input_image_path) as img:
#         # Convert to 'RGBA'
#         rgba_image = img.convert('RGBA')
#         img_byte_arr = io.BytesIO()
#         rgba_image.save(img_byte_arr, format='PNG')
#         img_byte_arr = img_byte_arr.getvalue()
        
#         # Check if the image is larger than 4MB
#         if img_byte_arr.getbuffer().nbytes >= 4 * 1024 * 1024:
#             print(f"Skipping {os.path.basename(input_image_path)} as it exceeds 4 MB.")
#             return
    
#     # Denoise the image using the OpenAI API
#     response = client.images.edit(
#         model="dall-e-2",
#         image=img_byte_arr,
#         prompt="Denoise this image to remove gaussian and salt and pepper and speckle noise. The output image should have a resolution of 512x512. The output image should be free of any noisy visual artifacts and should look like a clean version of the input image.",
#         n=1,
#         size="512x512"
#     )

#     image_url = response.data[0].url
#     output_image_path = os.path.join(output_folder, os.path.basename(input_image_path))
#     download_image(image_url, output_image_path)

# def download_image(image_url, output_path):
#     response = requests.get(image_url)
#     if response.status_code == 200:
#         with open(output_path, 'wb') as f:
#             f.write(response.content)
#     else:
#         print(f"Error downloading image: {response.status_code}")

# main_directory = "/Users/cheffbcookin/Desktop/EC520/AI-Image_Processing_Tasks/noised_images"
# output_directory = "/Users/cheffbcookin/Desktop/EC520/AI-Image_Processing_Tasks/denoised_images_dalle"
# os.makedirs(output_directory, exist_ok=True)

# for noise_type_dir in os.listdir(main_directory):
#     noise_type_path = os.path.join(main_directory, noise_type_dir)
#     if os.path.isdir(noise_type_path):
#         print(f"Processing images in {noise_type_dir}")
#         for variance_dir in os.listdir(noise_type_path):
#             variance_path = os.path.join(noise_type_path, variance_dir)
#             if os.path.isdir(variance_path):
#                 print(f"Processing file in {noise_type_dir}: {variance_dir}")
#                 output_subdir = os.path.join(output_directory, noise_type_dir, variance_dir)
#                 os.makedirs(output_subdir, exist_ok=True)
#                 for image_file in os.listdir(variance_path):
#                     if image_file.lower().endswith(('.png', '.tif', '.tiff')):
#                         print(f"Processing image: {image_file}")
#                         image_path = os.path.join(variance_path, image_file)
#                         generate_denoised_image(image_path, output_subdir)
#                         print(f"Denoised image saved to {output_subdir}")

# print("Denoising complete for all images.")

import os
from openai import OpenAI
from PIL import Image
import io
import requests

# Initialize OpenAI client with your API key
client = OpenAI()

def generate_denoised_image(input_image_path, output_folder):
    with Image.open(input_image_path) as img:
        # Convert to 'RGBA' and store as PNG in a BytesIO buffer
        img_byte_arr = io.BytesIO()
        img.convert('RGBA').save(img_byte_arr, format='PNG')
        img_byte_arr.seek(0)  # Rewind the buffer to the beginning

        # Check if the image size is acceptable for the API
        if img_byte_arr.getbuffer().nbytes >= 4 * 1024 * 1024:
            print(f"Skipping {os.path.basename(input_image_path)} as it exceeds 4 MB.")
            return
        
        # Prepare the image for the API
        image_data = img_byte_arr.getvalue()

    # Denoise the image using the OpenAI API
    response = client.images.edit(
        model="dall-e-2",
        image=image_data,
        prompt="Denoise this image to remove gaussian and salt and pepper noise.",
        n=1,
        size="512x512"
    )

    image_url = response.data[0].url
    output_image_path = os.path.join(output_folder, os.path.basename(input_image_path))
    download_image(image_url, output_image_path)

def download_image(image_url, output_path):
    response = requests.get(image_url)
    if response.status_code == 200:
        with open(output_path, 'wb') as f:
            f.write(response.content)
    else:
        print(f"Error downloading image: {response.status_code}")

main_directory = "/Users/cheffbcookin/Desktop/EC520/AI-Image_Processing_Tasks/noised_images"
output_directory = "/Users/cheffbcookin/Desktop/EC520/AI-Image_Processing_Tasks/denoised_images_dalle"
os.makedirs(output_directory, exist_ok=True)

for noise_type_dir in os.listdir(main_directory):
    noise_type_path = os.path.join(main_directory, noise_type_dir)
    if os.path.isdir(noise_type_path):
        for variance_dir in os.listdir(noise_type_path):
            variance_path = os.path.join(noise_type_path, variance_dir)
            if os.path.isdir(variance_path):
                output_subdir = os.path.join(output_directory, noise_type_dir, variance_dir)
                os.makedirs(output_subdir, exist_ok=True)
                for image_file in os.listdir(variance_path):
                    if image_file.lower().endswith(('.png', '.tif', '.tiff')):
                        image_path = os.path.join(variance_path, image_file)
                        print(f"Processing image: {image_file}")
                        generate_denoised_image(image_path, output_subdir)
                        print(f"Denoised image saved to {output_subdir}")

print("Denoising complete for all images.")
