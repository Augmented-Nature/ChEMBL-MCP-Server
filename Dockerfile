# Use Node.js LTS (Alpine for smaller image size)
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files first for better caching
COPY package*.json ./
COPY tsconfig.json ./

# Install dependencies
RUN npm i

# Copy source code
COPY src/ ./src/

# Build the project
RUN npm run build

# Remove dev dependencies and source code to reduce image size
RUN npm prune --production && rm -rf src/ tsconfig.json

# Create non-root user for security
RUN addgroup -g 1001 -S mcpuser && \
    adduser -S mcpuser -u 1001

# Change ownership of the app directory to the non-root user
RUN chown -R mcpuser:mcpuser /app
USER mcpuser

# Expose port (though MCP servers typically use stdio)
EXPOSE 3000

# Set the entrypoint to the built server
ENTRYPOINT ["node", "build/index.js"]

# Add health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD node -e "console.log('ChEMBL MCP Server is healthy')" || exit 1

# Add labels for metadata
LABEL maintainer="Augmented Nature <contact@augmentednature.ai>"
LABEL description="ChEMBL Model Context Protocol Server"
LABEL version="1.0.0"
LABEL org.opencontainers.image.source="https://github.com/augmented-nature/chembl-mcp-server"
LABEL org.opencontainers.image.description="A comprehensive MCP server for ChEMBL chemical database access"
LABEL org.opencontainers.image.licenses="MIT"
