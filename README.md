[![MseeP.ai Security Assessment Badge](https://mseep.net/pr/augmented-nature-chembl-mcp-server-badge.png)](https://mseep.ai/app/augmented-nature-chembl-mcp-server)

![ChEMBL MCP Server Logo](chembl-mcp-server-logo.png)

# **Unofficial** ChEMBL MCP Server

A comprehensive Model Context Protocol (MCP) server providing advanced access to the ChEMBL chemical database. This server offers 22 specialized tools enabling AI assistants and MCP clients to perform sophisticated drug discovery research, chemical informatics analysis, and bioactivity investigations directly through ChEMBL's REST API.

**Developed by [Augmented Nature](https://augmentednature.ai)**

## Features

### **Core Chemical Search & Retrieval (5 tools)**

- **Compound Search**: Search the ChEMBL database by compound name, synonym, or identifier
- **Detailed Compound Info**: Retrieve comprehensive compound information including structure, properties, and annotations
- **InChI-based Search**: Find compounds by InChI key or InChI string
- **Structure Retrieval**: Get chemical structure information in various formats (SMILES, InChI, MOL, SDF)
- **Similarity Search**: Find chemically similar compounds using Tanimoto similarity

### **Target Analysis & Drug Discovery (5 tools)**

- **Target Search**: Search for biological targets by name or type
- **Detailed Target Info**: Retrieve comprehensive target information and annotations
- **Target Compounds**: Get compounds tested against specific targets
- **UniProt Integration**: Find ChEMBL targets by UniProt accession numbers
- **Target Pathways**: Associated biological pathways and mechanisms

### **Bioactivity & Assay Data (5 tools)**

- **Activity Search**: Search bioactivity measurements and assay results
- **Detailed Assay Info**: Get comprehensive assay protocols and conditions
- **Activity Type Search**: Find bioactivity data by specific activity type and value range
- **Dose-Response Analysis**: Get dose-response data and activity profiles
- **Activity Comparison**: Compare bioactivity data across multiple compounds or targets

### **Drug Development & Clinical Data (4 tools)**

- **Drug Search**: Search for approved drugs and clinical candidates
- **Drug Development Status**: Get drug development status and clinical trial information
- **Therapeutic Indications**: Search for therapeutic indications and disease areas
- **Mechanism of Action**: Get mechanism of action and target interaction data

### **Chemical Property Analysis (4 tools)**

- **ADMET Analysis**: Analyze ADMET properties (Absorption, Distribution, Metabolism, Excretion, Toxicity)
- **Molecular Descriptors**: Calculate molecular descriptors and physicochemical properties
- **Solubility Prediction**: Predict aqueous solubility and permeability properties
- **Drug-Likeness Assessment**: Assess drug-likeness using Lipinski Rule of Five and other metrics

### **Advanced Search & Cross-References (4 tools)**

- **Substructure Search**: Find compounds containing specific substructures
- **Batch Processing**: Process multiple ChEMBL IDs efficiently
- **External References**: Get links to external databases (PubChem, DrugBank, PDB, etc.)
- **Advanced Search**: Complex queries with multiple chemical and biological filters

### **Resource Templates**

- Direct access to ChEMBL data via URI templates for seamless integration

## Installation

### Prerequisites

- Node.js (v16 or higher)
- npm or yarn

### Setup

1. Clone the repository:

```bash
git clone <repository-url>
cd chembl-server
```

2. Install dependencies:

```bash
npm install
```

3. Build the project:

```bash
npm run build
```

## Docker

### Building the Docker Image

Build the Docker image:

```bash
docker build -t chembl-mcp-server .
```

### Running with Docker

Run the container:

```bash
docker run -i chembl-mcp-server
```

For MCP client integration, you can use the container directly:

```json
{
  "mcpServers": {
    "chembl": {
      "command": "docker",
      "args": ["run", "-i", "chembl-mcp-server"],
      "env": {}
    }
  }
}
```

## Usage

### As an MCP Server

The server is designed to run as an MCP server that communicates via stdio:

```bash
npm start
```

### Adding to MCP Client Configuration

Add the server to your MCP client configuration (e.g., Claude Desktop):

```json
{
  "mcpServers": {
    "chembl": {
      "command": "node",
      "args": ["/path/to/chembl-server/build/index.js"],
      "env": {}
    }
  }
}
```

## Available Tools

### 1. search_compounds

Search the ChEMBL database for compounds by name, synonym, or identifier.

**Parameters:**

- `query` (required): Search query (compound name, synonym, or identifier)
- `limit` (optional): Number of results to return (1-1000, default: 25)
- `offset` (optional): Number of results to skip (default: 0)

**Example:**

```javascript
{
  "query": "aspirin",
  "limit": 10
}
```

### 2. get_compound_info

Get detailed information for a specific compound by ChEMBL ID.

**Parameters:**

- `chembl_id` (required): ChEMBL compound ID (e.g., CHEMBL25)

**Example:**

```javascript
{
  "chembl_id": "CHEMBL25"
}
```

### 3. search_targets

Search for biological targets by name or type.

**Parameters:**

- `query` (required): Target name or search query
- `target_type` (optional): Target type filter (e.g., SINGLE PROTEIN, PROTEIN COMPLEX)
- `organism` (optional): Organism filter
- `limit` (optional): Number of results to return (1-1000, default: 25)

**Example:**

```javascript
{
  "query": "dopamine receptor",
  "organism": "Homo sapiens",
  "limit": 5
}
```

### 4. search_activities

Search bioactivity measurements and assay results.

**Parameters:**

- `target_chembl_id` (optional): ChEMBL target ID filter
- `assay_chembl_id` (optional): ChEMBL assay ID filter
- `molecule_chembl_id` (optional): ChEMBL compound ID filter
- `activity_type` (optional): Activity type (e.g., IC50, Ki, EC50)
- `limit` (optional): Number of results to return (1-1000, default: 25)

**Example:**

```javascript
{
  "target_chembl_id": "CHEMBL2095173",
  "activity_type": "IC50",
  "limit": 50
}
```

### 5. batch_compound_lookup

Process multiple ChEMBL IDs efficiently.

**Parameters:**

- `chembl_ids` (required): Array of ChEMBL compound IDs (1-50)

**Example:**

```javascript
{
  "chembl_ids": ["CHEMBL25", "CHEMBL59", "CHEMBL1642"]
}
```

## Resource Templates

The server provides direct access to ChEMBL data through URI templates:

### 1. Compound Information

- **URI**: `chembl://compound/{chembl_id}`
- **Description**: Complete compound information for a ChEMBL ID
- **Example**: `chembl://compound/CHEMBL25`

### 2. Target Information

- **URI**: `chembl://target/{chembl_id}`
- **Description**: Complete target information for a ChEMBL target ID
- **Example**: `chembl://target/CHEMBL2095173`

### 3. Assay Information

- **URI**: `chembl://assay/{chembl_id}`
- **Description**: Complete assay information for a ChEMBL assay ID
- **Example**: `chembl://assay/CHEMBL1217643`

### 4. Activity Information

- **URI**: `chembl://activity/{activity_id}`
- **Description**: Bioactivity measurement data for an activity ID
- **Example**: `chembl://activity/12345678`

### 5. Search Results

- **URI**: `chembl://search/{query}`
- **Description**: Search results for compounds matching the query
- **Example**: `chembl://search/aspirin`

## Examples

### Basic Compound Search

Search for aspirin-related compounds:

```javascript
// Tool call
{
  "tool": "search_compounds",
  "arguments": {
    "query": "aspirin",
    "limit": 5
  }
}
```

### Get Detailed Compound Information

Retrieve comprehensive information about aspirin:

```javascript
// Tool call
{
  "tool": "get_compound_info",
  "arguments": {
    "chembl_id": "CHEMBL25"
  }
}
```

### Target-based Search

Find compounds tested against dopamine receptors:

```javascript
// Tool call
{
  "tool": "search_targets",
  "arguments": {
    "query": "dopamine receptor D2",
    "organism": "Homo sapiens"
  }
}
```

### Bioactivity Analysis

Search for IC50 data against a specific target:

```javascript
// Tool call
{
  "tool": "search_activities",
  "arguments": {
    "target_chembl_id": "CHEMBL2095173",
    "activity_type": "IC50",
    "limit": 100
  }
}
```

### Batch Processing

Process multiple compounds efficiently:

```javascript
// Tool call
{
  "tool": "batch_compound_lookup",
  "arguments": {
    "chembl_ids": ["CHEMBL25", "CHEMBL59", "CHEMBL1642", "CHEMBL1201585"]
  }
}
```

## API Integration

This server integrates with the ChEMBL REST API for programmatic access to chemical data. For more information about ChEMBL:

- **ChEMBL Website**: https://www.ebi.ac.uk/chembl/
- **API Documentation**: https://chembl.gitbook.io/chembl-interface-documentation/web-services
- **REST API Guide**: https://www.ebi.ac.uk/chembl/api/data/docs

All API requests include:

- **User-Agent**: `ChEMBL-MCP-Server/1.0.0`
- **Timeout**: 30 seconds
- **Base URL**: `https://www.ebi.ac.uk/chembl/api/data`

## Error Handling

The server includes comprehensive error handling:

- **Input Validation**: All parameters are validated using type guards
- **API Errors**: Network and API errors are caught and returned with descriptive messages
- **Timeout Handling**: Requests timeout after 30 seconds
- **Graceful Degradation**: Partial failures are handled appropriately

## Development

### Build the Project

```bash
npm run build
```

### Development Mode

Run TypeScript compiler in watch mode:

```bash
npm run dev
```

### Project Structure

```
chembl-server/
├── src/
│   └── index.ts          # Main server implementation
├── build/                # Compiled JavaScript output
├── package.json          # Node.js dependencies and scripts
├── tsconfig.json         # TypeScript configuration
└── README.md            # This file
```

## Dependencies

- **@modelcontextprotocol/sdk**: Core MCP SDK for server implementation
- **axios**: HTTP client for ChEMBL API requests
- **typescript**: TypeScript compiler for development

## License

MIT License

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## Support

For issues and questions:

1. Check the [ChEMBL API documentation](https://chembl.gitbook.io/chembl-interface-documentation/web-services)
2. Review the [Model Context Protocol specification](https://modelcontextprotocol.io/)
3. Open an issue on the repository

## About Augmented Nature

This comprehensive ChEMBL MCP Server is developed by **[Augmented Nature](https://augmentednature.ai)**, a leading innovator in AI-powered bioinformatics and computational chemistry solutions. Augmented Nature specializes in creating advanced tools that bridge the gap between artificial intelligence and chemical research, enabling researchers to unlock deeper insights from chemical and biological data.

## Complete Tool Reference

### **Core Chemical Search & Retrieval Tools**

1. `search_compounds` - Search ChEMBL database by name, synonym, or identifier
2. `get_compound_info` - Get detailed compound information by ChEMBL ID
3. `search_by_inchi` - Find compounds by InChI key or InChI string
4. `get_compound_structure` - Retrieve chemical structures in various formats
5. `search_similar_compounds` - Find chemically similar compounds using Tanimoto similarity

### **Target Analysis & Drug Discovery Tools**

6. `search_targets` - Search for biological targets by name or type
7. `get_target_info` - Get detailed target information by ChEMBL target ID
8. `get_target_compounds` - Get compounds tested against specific targets
9. `search_by_uniprot` - Find ChEMBL targets by UniProt accession
10. `get_target_pathways` - Get biological pathways associated with targets

### **Bioactivity & Assay Data Tools**

11. `search_activities` - Search bioactivity measurements and assay results
12. `get_assay_info` - Get detailed assay information by ChEMBL assay ID
13. `search_by_activity_type` - Find bioactivity data by activity type and value range
14. `get_dose_response` - Get dose-response data and activity profiles
15. `compare_activities` - Compare bioactivity data across multiple compounds

### **Drug Development & Clinical Data Tools**

16. `search_drugs` - Search for approved drugs and clinical candidates
17. `get_drug_info` - Get drug development status and clinical trial information
18. `search_drug_indications` - Search for therapeutic indications and disease areas
19. `get_mechanism_of_action` - Get mechanism of action and target interaction data

### **Chemical Property Analysis Tools**

20. `analyze_admet_properties` - Analyze ADMET properties
21. `calculate_descriptors` - Calculate molecular descriptors and physicochemical properties
22. `predict_solubility` - Predict aqueous solubility and permeability properties
23. `assess_drug_likeness` - Assess drug-likeness using Lipinski Rule of Five

### **Advanced Search & Cross-Reference Tools**

24. `substructure_search` - Find compounds containing specific substructures
25. `batch_compound_lookup` - Process multiple ChEMBL IDs efficiently
26. `get_external_references` - Get links to external databases
27. `advanced_search` - Complex queries with multiple chemical and biological filters

## Changelog

### v1.0.0 - Initial Release

- **Comprehensive Chemical Intelligence**: 27 specialized tools for drug discovery
- **Core Functionality**: Compound search, target analysis, bioactivity data
- **Advanced Features**: Similarity search, batch processing, cross-references
- **Resource Templates**: Direct URI-based access to ChEMBL data
- **Docker Support**: Containerized deployment with security best practices
- **Professional Documentation**: Complete tool reference and examples
- **Developed by Augmented Nature**: Professional chemical informatics platform

## Citation
If you use this project in your research or publications, please cite it as follows:

```bibtex @misc{chemblmcp2025, 
author = {Moudather Chelbi},
title = {ChEMBL MCP Server},
year = {2025},
howpublished = {https://github.com/Augmented-Nature/ChEMBL-MCP-Server},
note = {Accessed: 2025-06-29}
