import itk

# definir la imagen con tipo de dato y dos dimensiones
ImageType = itk.Image[itk.UC, 2]
# definir un lector para la imagen e inicializarlo
reader = itk.ImageFileReader[ImageType].New()
# definir un escritor para la imagen e inicializarlo
writer = itk.ImageFileWriter[ImageType].New()
# asignar al lector el nombre del archivo de entrada
reader.SetFileName("eje1.DCM")
# asignar al escritor el nombre del archivo de salida
writer.SetFileName("outputImage.hdr")
# conectar el lector y el escritor
writer.SetInput( reader.GetOutput() )
# ejecutar el proceso completo
writer.Update()