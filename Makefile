MODEL_NAME?=facebook/opt-125m

finetune:
	torchrun --nnodes 1  --nproc_per_node 2 scripts/supervised_finetuning.py --model_path=${MODEL_NAME} --streaming --no_gradient_checkpointing --learning_rate 1e-5 --max_steps 5000 --output_dir ./opt-125m-eli5
reward:
	torchrun --nnodes 1  --nproc_per_node 2 scripts/reward_modeling.py --model_name=./opt-125m-eli5
rl:
	accelerate launch --multi_gpu --num_machines 1  --num_processes 8 scripts/rl_training.py --log_with=wandb --model_name=./opt-125m-eli5-rm --reward_model_name=./opt-125m-eli5-rw --adafactor=False --tokenizer_name=${MODEL_NAME} --save_freq=100 --output_max_length=128 --batch_size=8 --gradient_accumulation_steps=8 --batched_gen=True --ppo_epochs=4 --seed=0 --learning_rate=1.4e-5 --early_stopping=True --output_dir=opt-125m-eli5-rl-finetune-128-8-8-1.4e-5_adam
merge-lora:
	python scripts/merge_peft_adapter.py --model_id=XXX --base_model_id=YYY --output_name=ZZZ