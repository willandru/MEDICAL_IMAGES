import matplotlib.pyplot as plt
import matplotlib.image as mpimg

# Ruta de las imágenes
ruta_imagen1 = 'hand.jpg'  # Reemplaza 'ruta_de_la_imagen1.jpg' con la ruta de tu primera imagen
ruta_imagen2 = 'g_hand.jpg'  # Reemplaza 'ruta_de_la_imagen2.jpg' con la ruta de tu segunda imagen

# Cargar las imágenes
imagen1 = mpimg.imread(ruta_imagen1)
imagen2 = mpimg.imread(ruta_imagen2)

# Crear la figura con 1 fila y 2 columnas
fig, axs = plt.subplots(1, 2, figsize=(10, 5))

# Mostrar la primera imagen en la primera columna
axs[0].imshow(imagen1)
axs[0].axis('off')  # Deshabilitar ejes
axs[0].set_title('Oroginal')

# Mostrar la segunda imagen en la segunda columna
axs[1].imshow(imagen2, cmap='gray')
axs[1].axis('off')  # Deshabilitar ejes
axs[1].set_title('Grises')

# Agregar título general para la figura
fig.suptitle('X-ray Hand', fontsize=16)

# Mostrar la figura
plt.show()
