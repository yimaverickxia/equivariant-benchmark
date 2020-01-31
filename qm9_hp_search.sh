#!/bin/bash
today=$(date +%Y%m%d)
db="qm9.db"
prefix="$2"

case "$1" in
  small)
    # Small
    targets="A B C mu alpha homo lumo gap r2 zpve U0 U H G Cv"
    split_file="default_split.npz"

    for target in $targets
    do
      model_dir=${prefix}${today}_${target}
      python qm9_train.py --model_dir "$model_dir" --split_file "$split_file" --db "$db" --wall 3500 --"$target"
    done
    ;;

  big)
    targets="A B C mu alpha homo lumo gap r2 zpve U0 U H G Cv"
    split_file="paper_split.npz"

    for target in $targets
    do
      model_dir=${prefix}${today}_${target}_64
      python qm9_train.py \
        --model_dir "$model_dir" \
        --split_file "$split_file" \
        --db "$db" \
        --wall 43200 \
        --"$target" \
        --ntr 109000 \
        --nva 1000 \
        --bs 16
    done
    ;;

  big_narrow)
    targets="A B C mu alpha homo lumo gap r2 zpve U0 U H G Cv"
    split_file="paper_split.npz"

    for target in $targets
    do
      model_dir=${prefix}${today}_${target}_64
      python qm9_train.py \
        --model_dir "$model_dir" \
        --split_file "$split_file" \
        --db "$db" \
        --wall 43200 \
        --"$target" \
        --ntr 109000 \
        --nva 1000 \
        --bs 16 \
        --l0 32
    done
    ;;

  big3)
    targets="A B C mu alpha homo lumo gap r2 zpve U0 U H G Cv"
    split_file="paper_split.npz"

    for target in $targets
    do
      model_dir=${prefix}${today}_${target}_64
      python qm9_train.py \
        --model_dir "$model_dir" \
        --split_file "$split_file" \
        --db "$db" \
        --wall 43200 \
        --"$target" \
        --ntr 109000 \
        --nva 1000 \
        --bs 16 \
        --L 3
    done
    ;;

  big_l1)
    targets="A B C mu alpha homo lumo gap r2 zpve U0 U H G Cv"
    split_file="paper_split.npz"

    for target in $targets
    do
      model_dir=${prefix}${today}_${target}_64_l1
      python qm9_train.py \
        --model_dir "$model_dir" \
        --split_file "$split_file" \
        --db "$db" \
        --wall 43200 \
        --"$target" \
        --ntr 109000 \
        --nva 1000 \
        --bs 16 \
        --l0 32 \
        --l1 10
    done
    ;;

  big_narrow_l1)
    targets="A B C mu alpha homo lumo gap r2 zpve U0 U H G Cv"
    split_file="paper_split.npz"

    for target in $targets
    do
      model_dir=${prefix}${today}_${target}_64_l1
      python qm9_train.py \
        --model_dir "$model_dir" \
        --split_file "$split_file" \
        --db "$db" \
        --wall 43200 \
        --"$target" \
        --ntr 109000 \
        --nva 1000 \
        --bs 16 \
        --l0 16 \
        --l1 5
    done
    ;;

  big3_l1)
    targets="A B C mu alpha homo lumo gap r2 zpve U0 U H G Cv"
    split_file="paper_split.npz"

    for target in $targets
    do
      model_dir=${prefix}${today}_${target}_64_l1
      python qm9_train.py \
        --model_dir "$model_dir" \
        --split_file "$split_file" \
        --db "$db" \
        --wall 43200 \
        --"$target" \
        --ntr 109000 \
        --nva 1000 \
        --bs 16 \
        --l0 32 \
        --l1 10 \
        --L 3
    done
    ;;

  u0_64)
    # Half schnet paper sized
    target="U0"
    split_file="paper_split.npz"
    model_dir=${2:-${today}_${target}_u0_64}
    python qm9_train.py \
        --model_dir "$model_dir" \
        --split_file "$split_file" \
        --db "$db" \
        --wall 172800 \
        --"$target" \
        --ntr 109000 \
        --nva 1000 \
        --bs 16
    ;;

  u0_64_l1)
    # Half schnet paper sized with l1
    target="U0"
    split_file="paper_split.npz"
    model_dir=${2:-${today}_${target}_u0_64_l1}
    python qm9_train.py \
      --model_dir "$model_dir" \
      --split_file "$split_file" \
      --db "$db" \
      --wall 86400 \
      --"$target" \
      --ntr 109000 \
      --nva 1000 \
      --bs 16 \
      --l0 32 \
      --l1 10
    ;;

  u0_128)
    # Paper sized
    target="U0"
    split_file="paper_split.npz"
    model_dir=${2:-${today}_${target}_u0_128}
    python qm9_train.py \
        --model_dir "$model_dir" \
        --split_file "$split_file" \
        --db "$db" \
        --wall 43200 \
        --"$target" \
        --ntr 109000 \
        --nva 1000 \
        --bs 32 \
        --l0 128 \
        --embed 128 \
        --rad_h 128
    ;;

  *)
    echo "$1" is not a possible argument.
    exit 1
esac
