Requirement to upload dta to Azure BLOB using SSIS
1. SSIS feature pack for Azure
Microsoft SQL Server 2014 Integration Services (SSIS) Feature Pack for Azure 
provides SSIS the capability of connecting to Azure Blob Storage, 
Azure HDInsight, Azure Data Lake Store and Azure SQL Data Warehouse.

2. Azure Storage Explorer
Easily manage the contents of your storage account with Azure Storage Explorer. 
Upload, download, and manage blobs, files, queues, and tables. 
Gain easy access to manage your virtual machine disks. 
Work with either Azure Resource Manager or classic storage accounts, 
plus manage and configure cross-origin resource sharing (CORS) rules.

## BLOB Storage
Azure Blob storage is a service for storing large amounts of unstructured object data, 
such as text or binary data, that can be accessed from anywhere in the world via HTTP or HTTPS. 
You can use Blob storage to expose data publicly to the world, or to store application data privately.

Common uses of Blob storage include:
1. Serving images or documents directly to a browser
2. Storing files for distributed access
3. Streaming video and audio
4. Storing data for backup and restore, disaster recovery, and archiving
5. Storing data for analysis by an on-premises or Azure-hosted service

## Blob service concepts
The Blob service contains the following components:

1. Storage Account: All access to Azure Storage is done through a storage account. 
					This storage account can be a General-purpose storage account or a Blob storage account 
					that is specialized for storing objects/blobs.
2. Container: 	A container provides a grouping of a set of blobs. 
				All blobs must be in a container. An account can contain an unlimited number of containers. 
				A container can store an unlimited number of blobs. Note that the container name must be lowercase.
3. Blob: 		A file of any type and size. 
				Azure Storage offers three types of blobs: 
				(i)		Block blobs:
				Block blobs are ideal for storing text or binary files, such as documents and media files.
				
				(ii)	Page blobs:
				Append blobs are similar to block blobs in that they are made up of blocks, 
				but they are optimized for append operations, so they are useful for logging scenarios. 
				A single block blob can contain up to 50,000 blocks of up to 100 MB each, 
				for a total size of slightly more than 4.75 TB (100 MB X 50,000). 
				A single append blob can contain up to 50,000 blocks of up to 4 MB each, 
				for a total size of slightly more than 195 GB (4 MB X 50,000).
				
				(iii)	Append blobs:
				Page blobs can be up to 1 TB in size, and are more efficient for frequent read/write operations. 
				Azure Virtual Machines uses page blobs as OS and data disks.

### Data Lake
A data lake is a storage repository that holds a vast amount of raw data in its native format, including structured, 
semi-structured, and unstructured data. The data structure and requirements are not defined until the data is needed.
A data lake is a hub or repository of all data that any organization has access to, 
where the data is ingested and stored in as close to the raw form as possible without enforcing any restrictive schema. 