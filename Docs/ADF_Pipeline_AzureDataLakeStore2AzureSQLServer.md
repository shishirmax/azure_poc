# ADF Pipeline using copy data for Azure Data Lake Store to Azure SQL Server.

Azure Data Lake Store(Source):
Azure SQL Server(Destination):

Pipeline: DataLake2AzureSqlServer
Input Dataset: InputDataset-knb
Output Dataset: OutputDataset-knb

Linked Services(inputDataset): Source-DataLakeStore-knb
Linked Services(outputDataset):Destination-SQLAzure

## JSON Configuration 

### DataSets

1. InputDataset-knb

```JSON
{
    "name": "InputDataset-knb",
    "properties": {
        "structure": [
            {
                "name": "CustomerID",
                "type": "String"
            },
            {
                "name": "Title",
                "type": "String"
            },
            {
                "name": "FirstName",
                "type": "String"
            },
            {
                "name": "MiddleName",
                "type": "String"
            },
            {
                "name": "LastName",
                "type": "String"
            },
            {
                "name": "CompanyName",
                "type": "String"
            },
            {
                "name": "EmailAddress",
                "type": "String"
            },
            {
                "name": "Phone",
                "type": "String"
            }
        ],
        "published": false,
        "type": "AzureDataLakeStore",
        "linkedServiceName": "Source-DataLakeStore-knb",
        "typeProperties": {
            "fileName": "CustomerData.csv",
            "folderPath": "pocCsvFiles",
            "format": {
                "type": "TextFormat",
                "columnDelimiter": ",",
                "skipLineCount": 1,
                "firstRowAsHeader": true
            }
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

2. OutputDataset-knb

```JSON
{
    "name": "OutputDataset-knb",
    "properties": {
        "structure": [
            {
                "name": "CustomerID",
                "type": "String"
            },
            {
                "name": "Title",
                "type": "String"
            },
            {
                "name": "FirstName",
                "type": "String"
            },
            {
                "name": "MiddleName",
                "type": "String"
            },
            {
                "name": "LastName",
                "type": "String"
            },
            {
                "name": "CompanyName",
                "type": "String"
            },
            {
                "name": "EmailAddress",
                "type": "String"
            },
            {
                "name": "Phone",
                "type": "String"
            }
        ],
        "published": false,
        "type": "AzureSqlTable",
        "linkedServiceName": "Destination-SQLAzure",
        "typeProperties": {
            "tableName": "[dbo].[customerData]"
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

1. Source-DataLakeStore-knb

```JSON
{
    "name": "Source-DataLakeStore-knb",
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

1. Destination-SQLAzure

```JSON
{
    "name": "Destination-SQLAzure",
    "properties": {
        "hubName": "gothamadfpoc_hub",
        "type": "AzureSqlDatabase",
        "typeProperties": {
            "connectionString": "Data Source=gothampoc.database.windows.net;Initial Catalog=gothamqa;Integrated Security=False;User ID=gothamadmin;Password=**********;Connect Timeout=30;Encrypt=True"
        }
    }
}
```

### Pipelines

1. DataLake2AzureSqlServer

```JSON
{
    "name": "DataLake2AzureSqlServer",
    "properties": {
        "description": "importing data from Data Lake Store to Azure Sql Server",
        "activities": [
            {
                "type": "Copy",
                "typeProperties": {
                    "source": {
                        "type": "AzureDataLakeStoreSource",
                        "recursive": false
                    },
                    "sink": {
                        "type": "SqlSink",
                        "writeBatchSize": 0,
                        "writeBatchTimeout": "00:00:00"
                    },
                    "translator": {
                        "type": "TabularTranslator",
                        "columnMappings": "1:CustomerID,Mr.:Title,Orlando:FirstName,N.:MiddleName,Gee:LastName,A Bike Store:CompanyName,orlando0@adventure-works.com:EmailAddress,245-555-0173:Phone"
                    }
                },
                "inputs": [
                    {
                        "name": "InputDataset-knb"
                    }
                ],
                "outputs": [
                    {
                        "name": "OutputDataset-knb"
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
                "name": "Activity-0-CustomerData_csv->[dbo]_[customerData]"
            }
        ],
        "start": "2017-11-02T00:00:00Z",
        "end": "2017-11-04T00:00:00Z",
        "isPaused": false,
        "hubName": "gothamadfpoc_hub",
        "pipelineMode": "Scheduled"
    }
}
```