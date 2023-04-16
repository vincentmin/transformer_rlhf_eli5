MODEL_NAME?=bigscience/bloomz-1b1

finetune:
	python scripts/supervised_finetuning.py --model_path=bigscience/bloomz-1b1 --no_gradient_checkpointing --learning_rate 1e-5 --max_steps 2500 --output_dir ./bloomz-1b1-eli5 --batch_size 16
reward:
	python scripts/reward_modeling.py --model_name=vincentmin/bloomz-1b1-eli5-pretrained
rl:
	python scripts/rl_training.py --log_with=tensorboard --model_name=vincentmin/bloomz-1b1-eli5 --reward_model_name=vincentmin/bloomz-1b1-eli5-reward --adafactor=False --save_freq=100 --output_max_length=128 --batch_size=8 --gradient_accumulation_steps=8 --batched_gen=True --ppo_epochs=4 --seed=0 --learning_rate=1.4e-5 --early_stopping=True --output_dir=bloomz-1b1-eli5-rl-finetune-128-8-8-1.4e-5_ada
merge-lora:
	python scripts/merge_peft_adapter.py --adapter_model_name=XXX --base_model_name=YYY --output_name=ZZZ