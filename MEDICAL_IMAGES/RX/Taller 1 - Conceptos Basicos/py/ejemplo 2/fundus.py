import itk

# definir la imagen de entrada con 3 canales (color) y dos dimensiones
InputImageType = itk.Image[itk.RGBPixel[itk.UC], 2]
# definir la imagen de salida con 1 canal (gris) y dos dimensiones
OutputImageType = itk.Image[itk.UC, 2]

# definir un lector para la imagen de entrada e inicializarlo
reader = itk.ImageFileReader[InputImageType].New()

# definir un proceso para cambiar los canales de la imagen (color a gris)
rgbFilter = itk.RGBToLuminanceImageFilter.New()

# definir un escritor para la imagen de salida e inicializarlo
writer = itk.ImageFileWriter[OutputImageType].New()

# asignar al lector el nombre del archivo de entrada
reader.SetFileName("fundus.jpg")
# asignar al escritor el nombre del archivo de salida
writer.SetFileName("g_fundus.jpg")
# conectar el proceso al lector para tomar la imagen de entrada
rgbFilter.SetInput(reader.GetOutput())
# conectar el escritor al proceso para tomar la imagen de salida
writer.SetInput(rgbFilter.GetOutput())
# ejecutar la linea de procesamiento completa
writer.Update()