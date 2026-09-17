from operations.add import suma
from operations.subtract import resta
from operations.multiply import multiplicacion
from operations.divide import division

operacion = int(input('Ingrese el número de la operación que desea hacer: \n1.Suma\n2.Resta\n3.Multiplicación\n4.División\n5.Salir\n -> '))

while operacion != 5:
    if operacion < 5 and operacion > 0:
        num1 = int(input('Ingrese un número: '))
        num2 = int(input('Ingrese el segundo número: '))
        if operacion == 1:
            print(f'El resultado de la suma es: {suma(num1, num2)}')
        elif operacion == 2:
            print(f'El resultado de la resta es: {resta(num1, num2)}')
        elif operacion == 3:
            print(f'El resultado de la multiplicación es: {multiplicacion(num1, num2)}')
        elif operacion == 4:
            print(f'El resultado de la división es: {division(num1, num2)}')
    else:
        operacion = int(input('Elija una opción válida.\n ->'))
    operacion = int(input('¿Desea realizar otra operación?\n1.Suma\n2.Resta\n3.Multiplicación\n4.División\n5.Salir\n ->'))
print('Adiós!')