# RLHF pipeline for the creation of a ELI5 model using RLHF.
There were three main steps to the training process:
1. Supervised fine-tuning:
   - `make supervised`
2. Reward modeling:
    - `make reward`
3. RL fine-tuning:
    - `make rl`


LoRA layers were using at all stages to reduce memory requirements. 
At each stage the peft adapter layers were merged with the base model, using: 
```shell
python merge_peft_adapter.py --adapter_model_name=XXX --base_model_name=YYY --output_name=ZZZ
```