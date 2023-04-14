// Alan Patricio González Bernal - A01065746
// Arturo Cristian Díaz López - A01709522

using System;

class Program
{
    static void Main()
    {
        Console.WriteLine("Calculadora de la fórmula general");
        Console.WriteLine("Ingrese los coeficientes de la ecuación cuadrática (ax^2 + bx + c = 0):");

        Console.Write("Ingrese a: ");
        double a = Convert.ToDouble(Console.ReadLine());

        Console.Write("Ingrese b: ");
        double b = Convert.ToDouble(Console.ReadLine());

        Console.Write("Ingrese c: ");
        double c = Convert.ToDouble(Console.ReadLine());

        double discriminante = b * b - 4 * a * c;

        if (discriminante < 0)
        {
            Console.WriteLine("La ecuación no tiene soluciones reales.");
        }
        else if (discriminante == 0)
        {
            double x = -b / (2 * a);
            Console.WriteLine($"La ecuación tiene una solución real: x = {x}");
        }
        else
        {
            double x1 = (-b + Math.Sqrt(discriminante)) / (2 * a);
            double x2 = (-b - Math.Sqrt(discriminante)) / (2 * a);
            Console.WriteLine($"La ecuación tiene dos soluciones reales: x1 = {x1} y x2 = {x2}");
        }
    }
}
