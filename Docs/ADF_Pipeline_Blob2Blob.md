# ADF Pipeline using copy data for Blob to Blob movement of data.

This complete document and process was ment to be created for the process of copying data from Blob storage to Data Lake Store, Since there was no Data Lake Store was created I have tested it with copying the data bewtween two different Blob Storage.

Blob(Source): ecrvsource
Blob(Destination):testcontainer

Pipeline: BlobToDataLake-Pipeline
Input Dataset: InputDataset-ntq
Output Dataset: OutputDataset-ntq

Linked Services(inputDataset): Source-BlobStorage-B2DL
Linked Services(outputDataset):Destination-BlobStorage-B2B

## JSON Configuration 

### DataSets

1. InputDataset-ntq

```JSON
{
    "name": "InputDataset-ntq",
    "properties": {
        "published": false,
        "type": "AzureBlob",
        "linkedServiceName": "Source-BlobStorage-B2DL",
        "typeProperties": {
            "folderPath": "ecrvsource/"
        },
        "availability": {
            "frequency": "Day",
            "interval": 1
        },
        "external": true,
        "policy": {}
    }
}
```

2. OutputDataset-ntq

```JSON
{
    "name": "OutputDataset-ntq",
    "properties": {
        "published": false,
        "type": "AzureBlob",
        "linkedServiceName": "Destination-BlobStorage-B2B",
        "typeProperties": {
            "folderPath": "testcontainer"
        },
        "availability": {
            "frequency": "Day",
            "interval": 1
        },
        "external": false,
        "policy": {}
    }
}
```

### Linked Services

1. Source-BlobStorage-B2DL

```JSON
{
    "name": "Source-BlobStorage-B2DL",
    "properties": {
        "hubName": "customer-analytics_hub",
        "type": "AzureStorage",
        "typeProperties": {
            "connectionString": "DefaultEndpointsProtocol=https;AccountName=contata;AccountKey=**********"
        }
    }
}
```

2. Destination-BlobStorage-B2B

```JSON
{
    "name": "Destination-BlobStorage-B2B",
    "properties": {
        "hubName": "customer-analytics_hub",
        "type": "AzureStorage",
        "typeProperties": {
            "connectionString": "DefaultEndpointsProtocol=https;AccountName=contatapowershell;AccountKey=**********"
        }
    }
}
```

### Pipelines

1. BlobToDataLake-Pipeline

```JSON
{
    "name": "BlobToDataLake-Pipeline",
    "properties": {
        "description": "Pipeline for copying data from blob storage to Data Lake",
        "activities": [
            {
                "type": "Copy",
                "typeProperties": {
                    "source": {
                        "type": "BlobSource",
                        "recursive": false
                    },
                    "sink": {
                        "type": "BlobSink",
                        "copyBehavior": "PreserveHierarchy",
                        "writeBatchSize": 0,
                        "writeBatchTimeout": "00:00:00"
                    }
                },
                "inputs": [
                    {
                        "name": "InputDataset-ntq"
                    }
                ],
                "outputs": [
                    {
                        "name": "OutputDataset-ntq"
                    }
                ],
                "policy": {
                    "timeout": "1.00:00:00",
                    "concurrency": 1,
                    "executionPriorityOrder": "NewestFirst",
                    "style": "StartOfInterval",
                    "retry": 3,
                    "longRetry": 0,
                    "longRetryInterval": "00:00:00"
                },
                "scheduler": {
                    "frequency": "Day",
                    "interval": 1
                },
                "name": "Activity-0-Blob path_ ecrvsource_->OutputDataset-ntq"
            }
        ],
        "start": "2017-10-29T00:00:00Z",
        "end": "2017-10-31T00:00:00Z",
        "isPaused": false,
        "hubName": "customer-analytics_hub",
        "pipelineMode": "Scheduled"
    }
}
```


