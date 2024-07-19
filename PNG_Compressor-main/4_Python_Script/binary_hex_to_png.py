from PIL import Image
from intelhex import IntelHex

def intel_hex_to_png(hex_filepath, png_filepath, width, height):
    # Intel Hex 파일 열기
    ih = IntelHex(hex_filepath)
    # 바이너리 스케일 데이터 생성
    binary_data = bytearray()
    for address in range(ih.minaddr(), ih.maxaddr() + 1):
        byte_value = ih[address]
        # 각 바이트에 있는 각 비트를 읽어서 0이면 흰색, 1이면 검정색으로 설정
        for i in range(8):
            if byte_value & (1 << i):  # 비트가 1이면
                binary_data.extend([255, 255, 255, 255])   
            else:
                binary_data.extend([0, 0, 0, 255])   
    # RGBA 데이터를 PNG 이미지로 변환
    img = Image.frombytes('RGBA', (width, height), bytes(binary_data))
    # PNG 파일로 저장
    img.save(png_filepath)
    print(f"PNG file '{png_filepath}' has been created.")

def intel_hex_to_png_reverse(hex_filepath, png_filepath, width, height):
    # Intel Hex 파일 열기
    ih = IntelHex(hex_filepath)
    # 바이너리 스케일 데이터 생성
    binary_data = bytearray()
    for address in range(ih.minaddr(), ih.maxaddr() + 1):
        byte_value = ih[address]
        # 각 바이트에 있는 각 비트를 읽어서 0이면 흰색, 1이면 검정색으로 설정
        for i in range(8):
            if byte_value & (1 << i):  # 비트가 1이면
                binary_data.extend([0, 0, 0, 255])   
            else:
                binary_data.extend([255, 255, 255, 255])  
    # RGBA 데이터를 PNG 이미지로 변환
    img = Image.frombytes('RGBA', (width, height), bytes(binary_data))
    # PNG 파일로 저장
    img.save(png_filepath)
    print(f"PNG file '{png_filepath}' has been created.")
    
# 예제 실행 코드
input_filename = input("input_hex (without extension): ")
intel_hex_to_png(input_filename+".hex", input_filename+".png", width=960, height=640) 
intel_hex_to_png_reverse(input_filename+".hex", input_filename+"_reverse.png", width=960, height=640) 

