# LineOfSight
Este repositório tem funções com o objetivo de verificar a existência de linha de visada entre uma antena na superfície e outros pontos.

## Dados artificiais
Foi usado o seguinte terreno para testar as funções

![terra_artificial_3D](https://user-images.githubusercontent.com/119422200/222736231-6b99b1c4-b1aa-4e19-8f79-523b46a7c6e4.png)

Traçou-se uma direção, na qual verificou-se a existência de linha de visada entre altitudes. A figura abaixo mostra a direção escolhida em um mapa de contorno da região acima.

![terra_artificial_2D](https://user-images.githubusercontent.com/119422200/222736732-8c4ab826-44d2-4829-b501-37eca332e6e7.png)

Onde o asterisco preto representa a antena.

Foram usados dois modelos para contabilizar a linha de visada: modelo de Terra plana e Terra esférica.
### Terra plana
A Figura abaixo mostra o resultado com modelo Terra plana

![direcao_visada_plana](https://user-images.githubusercontent.com/119422200/222737366-fb9ebf0f-ed2e-4b96-997a-8a0b30850601.png)

### Terra esférica
A Figura abaixo mostra o resultado com modelo Terra esférica

![direcao_visada_esferica](https://user-images.githubusercontent.com/119422200/222737554-68691f62-6fa8-4aa2-967b-e6379519461c.png)

E foi plotado o resultado obtido pelo modelo esférico, mas considerando a Terra plana:

![direcao_visada_esferica_plana](https://user-images.githubusercontent.com/119422200/222737671-7b108a28-10bb-4223-9e87-3d09c5885a46.png)

## Dados reais
Foi dados reais de altitude da região sudeste do Brasil, englobando a cidade de São José dos Campos.

![regiao_SJC](https://user-images.githubusercontent.com/119422200/222738106-82d281de-2d38-4a26-b1aa-dad5ddac9b87.png)

Onde o asterisco vermelho indica a posição da antena. Os dois modelos foram então usados para verificar as altitudes de linha de visada entre a antena e outros pontos.

### Terra plana
A Figura abaixo mostra o resultado com modelo Terra plana

![regiao_SJC_plana](https://user-images.githubusercontent.com/119422200/222738508-09c2cb05-13b9-4834-ab17-1e54091fceb1.png)

### Terra esférica
A Figura abaixo mostra o resultado com modelo Terra esférica

![regiao_SJC_esferica](https://user-images.githubusercontent.com/119422200/222738557-500fa2ca-774a-437e-8aa3-604e39effdd4.png)
