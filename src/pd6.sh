#!/usr/bin/env bash

# Garantindo que o current path seja o src/
BASEDIR=$(dirname "$0")
cd $BASEDIR

show_help()
{
    echo "Uso do programa:"
    echo "$0 argumentos [--no-gpu]"
    echo ""
    echo "argumentos:"
    echo "--load-data          Realiza a carga de dados do NYUDv2"
    echo "--train-original     Treina o modelo FuseNet original"
    echo "--train-no-cbr5      Treina o modelo FuseNet modificado sem a CBR 5 do branch depth"
    echo "--train-no-cbr4-5    Treina o modelo FuseNet modificado sem as CBRs 4 e 5 do branch depth"
    echo "--train-no-cbr2-5    Treina o modelo FuseNet modificado sem as CBRs 2 a 5 do branch depth"
    echo "--train-no-depth     Treina o modelo FuseNet modificado sem o branch depth"
    echo "--train-cbr5-only    Treina o modelo FuseNet modificado somente com a fusao da CBR 5 do branch depth"
    echo "--test               Testa o modelo FuseNet previamente treinado"
    echo ""
}

load_data()
{
    cd datasets
    sh download_nyuv2.sh
    python3 create_training_set.py
    cd ..
}

train_model()
{
    python3 -m visdom.server > /dev/null 2> /dev/null &    
    python3 train.py --dataroot datasets/nyuv2 --dataset nyuv2 --name nyuv2 --niter 3 --save_epoch_freq 1 --no_html
}

test_model()
{
    python3 -m visdom.server > /dev/null 2> /dev/null &    
    python3 test.py --dataroot datasets/nyuv2 --dataset nyuv2 --name nyuv2
}


if [ $# -eq 1 ]; then
        
    if [ "$1" == "--load-data" ]; then
        load_data
    elif [ "$1" == "--train-original" ]; then
        cd models
        ln -sf networks_orig.py networks.py
        cd ..
        train_model
    elif [ "$1" == "--train-no-cbr5" ]; then
        cd models
        ln -sf networks_no_cbr5.py networks.py
        cd ..
        train_model
    elif [ "$1" == "--train-no-cbr4-5" ]; then
        cd models
        ln -sf networks_no_cbr4-5.py networks.py
        cd ..
        train_model
    elif [ "$1" == "--train-no-cbr2-5" ]; then
        cd models
        ln -sf networks_no_cbr2-5.py networks.py
        cd ..
        train_model
    elif [ "$1" == "--train-no-depth" ]; then
        cd models
        ln -sf networks_no_depth.py networks.py
        cd ..
        train_model
    elif [ "$1" == "--train-cbr5-only" ]; then
        cd models
        ln -sf networks_only_cbr5.py networks.py
        cd ..
        train_model
    elif [ "$1" == "--test" ]; then
        test_model
    else
        show_help
        exit 1
    fi

else
    show_help
    exit 1
fi


