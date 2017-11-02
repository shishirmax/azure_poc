# ADF Pipeline using copy data for Blob to Azure Data Lake Store.

Blob(Source): 
Azure Data Lake Store(Destination):

Pipeline: CopyToDataLakeStore
Input Dataset: InputDataset-yri
Output Dataset: OutputDataset-yri

Linked Services(inputDataset): Source-BlobStorage
Linked Services(outputDataset):Destination-DataLakeStore

## JSON Configuration 

### DataSets

1. InputDataset-yri

```JSON
{
    "name": "InputDataset-yri",
    "properties": {
        "published": false,
        "type": "AzureBlob",
        "linkedServiceName": "Source-BlobStorage",
        "typeProperties": {
            "folderPath": "samplecsvfiles/"
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

1. OutputDataset-yri

```JSON
{
    "name": "OutputDataset-yri",
    "properties": {
        "published": false,
        "type": "AzureDataLakeStore",
        "linkedServiceName": "Destination-DataLakeStore",
        "typeProperties": {
            "folderPath": "pocCsvFiles"
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

1. Source-BlobStorage

```JSON
{
    "name": "Source-BlobStorage",
    "properties": {
        "hubName": "gothamadfpoc_hub",
        "type": "AzureStorage",
        "typeProperties": {
            "connectionString": "DefaultEndpointsProtocol=https;AccountName=gothamsapoc;AccountKey=**********"
        }
    }
}
```

1. Destination-DataLakeStore

```JSON
{
    "name": "Destination-DataLakeStore",
    "properties": {
        "hubName": "gothamadfpoc_hub",
        "type": "AzureDataLakeStore",
        "typeProperties": {
            "dataLakeStoreUri": "https://dlspoc.azuredatalakestore.net/webhdfs/v1",
            "servicePrincipalId": "",
            "servicePrincipalKey": "**********",
            "tenant": "",
            "authorization": "**********",
            "sessionId": "**********",
            "subscriptionId": "673353f6-efda-4969-aba3-49dd49121bb2",
            "resourceGroupName": "dlspocrg"
        }
    }
}
```

### Pipelines

1. CopyToDataLakeStore

```JSON
{
    "name": "CopyToDataLakeStore",
    "properties": {
        "description": "Copy files from blob storage to Azure Data Lake Store",
        "activities": [
            {
                "type": "Copy",
                "typeProperties": {
                    "source": {
                        "type": "BlobSource",
                        "recursive": false
                    },
                    "sink": {
                        "type": "AzureDataLakeStoreSink",
                        "copyBehavior": "PreserveHierarchy",
                        "writeBatchSize": 0,
                        "writeBatchTimeout": "00:00:00"
                    }
                },
                "inputs": [
                    {
                        "name": "InputDataset-yri"
                    }
                ],
                "outputs": [
                    {
                        "name": "OutputDataset-yri"
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
                "name": "Activity-0-Blob path_ samplecsvfiles_->OutputDataset-yri"
            }
        ],
        "start": "2017-10-31T00:00:00Z",
        "end": "2017-11-05T00:00:00Z",
        "isPaused": false,
        "hubName": "gothamadfpoc_hub",
        "pipelineMode": "Scheduled"
    }
}
```