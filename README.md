# FuseNet: a profundiade realmente ajuda?

Este é um trabalho acadêmico da disciplina de Visão Computacional do Prof.Teófilo do CIC/UnB.

OBS: O código-fonte contido na pasta src é a implementação de [Aygün](https://github.com/MehmetAygun/fusenet-pytorch) do FuseNet para o Pytorch, tendo sido realizada apenas algumas adaptações pontuais para consecução dos objetivos deste trabalho. Obrigado, Aygün !!

## Requisitos
- Linux
- OpenCV 3+
- Python 3.6.8
- Pytorch 1.3.1
- CPU or NVIDIA GPU + CUDA CuDNN
(**atenção**: o Pytorch utiliza o CUDA no treinamento e teste da CNN)
- Numpy 1.16.1
(**atenção**: a versão do numpy não pode ser maior do que essa, por conta de incompatibilidade do código implementado)
- Scipy 1.1.0
(**atenção**: a versão do scipy não pode ser maior do que essa, por conta de incompatibilidade do código implementado)
- visdom 0.1.8.5
- h5py
- dominate
- outros (consultar src/requirements.txt)

## Estrutura
- Pasta _relatorio_ com código fonte do relatório
- Arquivo _Leonardo_Loriato.pdf_ com o relatório
- Pasta _src_ contendo o código principal do projeto, cujos principais arquivos são:
  - _pd5.py_ - Arquivo principal do projeto, que deve ser executado para fins de verificação da tarefa
  - _train.py_ - Programa do Aygün utilizado para treinamento do FuseNet
  - _test.py_ - Programa do Aygün utilizado para teste do FuseNet
  - _requirements.txt_ - Arquivos com as dependências Python do Projeto
  - _checkpoints_ - Diretório criado durante o treinamento para armazenamento temporário dos dados do modelo
  - _checkpoints/nyuv2/latest_net_FuseNet.pth_ - arquivo em que são salvos os pesos da FuseNet, necessários para o teste

## Instalação e configuração
- Instale o [OpenCV 3+](https://www.learnopencv.com/install-opencv3-on-ubuntu/)
- Instale o Python 3 e o Pip3 (se não estiverem instalados)
```bash
sudo apt-get update
sudo apt-get install python3 python3-pip
```
- Instale as dependências do projeto
```bash
pip3 install -r requirements.txt
```
- Por via das dúvidas, assegure que os seguintes pacotes foram instalados:
```bash
pip3 install torch torchvision torchfile
pip3 install h5py
pip3 install dominate
pip3 install visdom
pip3 install scipy==1.1.0
pip3 install numpy==1.16.1
```


## Carga de dados do NYUDv2
- Execute os seguintes comandos:
```bash
cd src
./pd6.sh --load-data
```
- É possível que o wget não consiga baixar corretamente os arquivos, dando erro durante o treinamento do modelo. Nesse caso, será necessário baixar manualmente os seguintes arquivos, salvando-os na pasta src/datasets
```bash
http://horatio.cs.nyu.edu/mit/silberman/nyu_depth_v2/nyu_depth_v2_labeled.mat
http://horatio.cs.nyu.edu/mit/silberman/indoor_seg_sup/splits.mat
https://github.com/tum-vision/fusenet/blob/master/fusenet/data/nyuv2_13class_mapping.mat
```
- Além disso, será necessário executar manualmente a preparação dos dados com o seguinte comando:
```bash
cd src/datasets
python create_training_set.py
```

## Treinamento dos modelos

### Modelo original da Fusenet
```bash
cd src
./pd6.sh --train-original
```

### Modelo modificado da Fusenet sem a CBR 5 do branch depth
```bash
cd src
./pd6.sh --train-no-cbr5
```

### Modelo modificado da Fusenet sem as CBR 4 e 5 do branch depth
```bash
cd src
./pd6.sh --train-no-cbr4-5
```

### Modelo modificado da Fusenet sem as CBR 2 a 5 do branch depth
```bash
cd src
./pd6.sh --train-no-cbr2-5
```

### Modelo modificado da Fusenet sem o branch depth
```bash
cd src
./pd6.sh --train-no-depth
```

### Modelo modificado da Fusenet somente com a fusão da CBR 5 do branch depth
```bash
cd src
./pd6.sh --train-cbr5-only
```

## Teste do modelo previamente treinado
```bash
cd src
./pd6.sh --test
```
### Visualização dos resultados
- Os dados estarão disponíveis em src/checkpoints/nyuv2/web
- Eles poderão ser visualizados por meio do visdom, bastando rodar o comando abaixo e acessar o seguinte [endereço](http://localhost:8097/):
```bash
python -m visdom.server
```
