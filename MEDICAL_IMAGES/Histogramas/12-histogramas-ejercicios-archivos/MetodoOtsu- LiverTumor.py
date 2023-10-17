import itk

# definir la imagen como volumen (3 dimensiones)
ImageType = itk.Image[itk.UC, 3]
# definir un lector para la imagen de entrada e inicializarlo
reader = itk.ImageFileReader[ImageType].New()
# definir el algoritmo de Otsu que binarizara la imagen
otsuFilter = itk.OtsuThresholdImageFilter[ImageType,ImageType].New()
# definir un escritor para la imagen de salida e inicializarlo
writer = itk.ImageFileWriter[ImageType].New()
# asignar al lector el nombre del archivo de entrada
reader.SetFileName("MRLiverTumor.nii.gz")
# asignar al escritor el nombre del archivo de salida
writer.SetFileName("MRLiverTumor_bin.nii.gz")
# conectar el algoritmo al lector para tomar la imagen de entrada
otsuFilter.SetInput(reader.GetOutput())
# conectar el escritor al algoritmo para tomar la imagen de salida
writer.SetInput(otsuFilter.GetOutput())
# ejecutar la linea de procesamiento completa
writer.Update()
# imprimir en pantalla el valor del umbral automatico
print(otsuFilter.GetThreshold())


import numpy as np
import matplotlib.pyplot as plt

# Convertir las imágenes ITK a matrices de NumPy para visualización
imagen_original_np = itk.array_from_image(reader.GetOutput())
imagen_binarizada_np = itk.array_from_image(otsuFilter.GetOutput())

# Visualizar la imagen original
plt.figure(figsize=(12, 6))
plt.subplot(1, 2, 1)
plt.imshow(imagen_original_np[:, :, imagen_original_np.shape[2] // 2], cmap='gray')
plt.title("Imagen Original")

# Visualizar la imagen binarizada
plt.subplot(1, 2, 2)
plt.imshow(imagen_binarizada_np[:, :, imagen_binarizada_np.shape[2] // 2], cmap='gray')
plt.title("Imagen Binarizada")

# Título de la figura en su totalidad
plt.suptitle("MRI Liver Tumor", fontsize=16)

plt.show()