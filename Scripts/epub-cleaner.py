import zipfile
import os
import shutil

def clean_epub_html(epub_path: str, output_path: str) -> None:
    """
    Opens an EPUB file (which is a ZIP archive), iterates through its HTML/XHTML
    files, and removes a specific line from each. Creates a new EPUB file
    with the modifications.

    Args:
        epub_path (str): The path to the original EPUB file.
        output_path (str, optional): The path for the new, cleaned EPUB file.   
    """

    # Define the line to be removed
    line_to_remove = '<div style="float: none; margin: 10px 0px 10px 0px; text-align: center;"><p><a href="https://oceanofpdf.com"><i>OceanofPDF.com</i></a></p></div>'
#                     <div style="float: none; margin: 10px 0px 10px 0px; text-align: center;"><p><a href="https://oceanofpdf.com"><i>OceanofPDF.com</i></a></p></div>

    # Determine the output path
    if output_path is None:
        temp_output_path = epub_path + ".temp_cleaned.epub"
    else:
        temp_output_path = output_path

    try:
        # Open the original EPUB for reading and the temporary new EPUB for writing
        with zipfile.ZipFile(epub_path, 'r') as original_epub, \
             zipfile.ZipFile(temp_output_path, 'w', zipfile.ZIP_DEFLATED) as new_epub:

            # Iterate through all files in the original EPUB
            for item in original_epub.infolist():
                file_name = item.filename

                # Check if the file is an HTML or XHTML file (case-insensitive)
                # and exclude directories (which end with '/')
                if (file_name.lower().endswith(('.html', '.xhtml')) and
                        not file_name.endswith('/')):
                    print(f"Processing HTML file: {file_name}")

                    # Read the content of the HTML file
                    content_bytes = original_epub.read(file_name)
                    # Decode content, assuming UTF-8, which is common for EPUB HTML
                    content_str = content_bytes.decode('utf-8')

                    # Remove the specific line
                    modified_content_str = content_str.replace(line_to_remove, '')

                    # Encode the modified content back to bytes
                    modified_content_bytes = modified_content_str.encode('utf-8')

                    # Write the modified content to the new EPUB
                    # Use writestr to retain original compression settings for the item if possible,
                    # otherwise, 'write' with 'item' can be used if exact copy is needed for metadata.
                    # For modifications, writestr is typically used.
                    new_epub.writestr(item, modified_content_bytes)

                else:
                    # For non-HTML files, copy them directly to the new EPUB
                    # Read the raw bytes and write them to the new archive
                    new_epub.writestr(item, original_epub.read(file_name))

        print(f"\nSuccessfully created cleaned EPUB at: {temp_output_path}")

        # If output_path was None, replace the original file
        if output_path is None:
            print(f"Replacing original EPUB file: {epub_path}")
            os.remove(epub_path)
            shutil.move(temp_output_path, epub_path)
            print("Original EPUB replaced with cleaned version.")

    except FileNotFoundError:
        print(f"Error: EPUB file not found at '{epub_path}'. Please check the path.")
    except zipfile.BadZipFile:
        print(f"Error: '{epub_path}' is not a valid ZIP file (or corrupted).")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")

# --- How to use the script ---
if __name__ == "__main__":
    # IMPORTANT: Replace 'your_book.epub' with the actual path to your EPUB file.
    input_epub_file = '/home/richard/Downloads/_OceanofPDF.com_Meditations_-_Gregory_Hays.epub'

    # Option 1: Overwrite the original file (if output_path is None or same as input)
    # clean_epub_html(input_epub_file)

    # Option 2: Save to a new file (e.g., 'your_book_cleaned.epub')
    output_epub_file = '/home/richard/Downloads/your_book_cleaned.epub'
    clean_epub_html(input_epub_file, output_epub_file)

    print(f"\nScript finished. Check '{output_epub_file}' for the cleaned EPUB.")
    print("If you chose to overwrite, check the original file path.")

    # --- Create a dummy EPUB for testing if it doesn't exist ---


