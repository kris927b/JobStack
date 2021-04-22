# Data folder for JobStack

In the JobStack paper we create our own data, which can be found here [NLPNorth.itu.dk](https://itu.dk).

However, we also use Multi Task Learning to improve performance. For that we use two sepereate datasets.

- [CoNLL 2003](https://github.com/pfliu-nlp/Named-Entity-Recognition-NER-Papers/tree/master/ner_dataset/CoNLL%2B%2B)
- [I2B2/UTHealth](https://portal.dbmi.hms.harvard.edu/projects/n2c2-nlp/)

To access the I2B2/UTHealth data set, you will have to sign their Data Use Agreement (DUA).

We also use a custom data set for our Masked Language Model experiments, which consists of many sentences collected from Stackoverflow job posts. 
This data set can also be found at our website [NLPNorth.itu.dk](https://itu.dk).

## Folder structure

For the scripts to work, you will need to have the following folder structure in the data folder.

```
.
+-- README.md
+-- conll
|   +-- train.conll
|   +-- dev.conll
+-- JobStack
|   +-- train.conll
|   +-- dev.conll
|   +-- test.conll
+-- i2b2
|   +-- train.conll
|   +-- dev.conll
+-- stack
|   +-- train.txt
|   +-- dev.txt
```