from transformers import (
    AutoModelForSequenceClassification,
    AutoTokenizer,
)

from HierarchicalBert import HierarchicalBert

max_segments = 2
max_doc_length = 1024
max_length = max_doc_length - max_segments * 2
device = 'cpu'  # 'cuda:0'

model_name = "deepset/gbert-base"
model = AutoModelForSequenceClassification.from_pretrained(model_name)
tokenizer = AutoTokenizer.from_pretrained(model_name)
encoder = model.bert
model.bert = HierarchicalBert(encoder,
                              max_segments=max_segments,
                              max_segment_length=512,
                              cls_token_id=tokenizer.cls_token_id,
                              sep_token_id=tokenizer.sep_token_id,
                              device=device,
                              seg_encoder_type='lstm')

batch = tokenizer(['a ' * 1024] * 4, truncation=True, padding='max_length',
                  max_length=max_length, add_special_tokens=False, return_tensors='pt')

outputs = model(batch['input_ids'], attention_mask=batch['attention_mask'], token_type_ids=batch['token_type_ids'])
print(outputs)
