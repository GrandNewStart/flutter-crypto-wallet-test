class Network {
  String name;
  String rpcUrl;
  int chainId;
  String symbol;
  String? blockExplorerUrl;

  Network(this.name, this.rpcUrl, this.chainId, this.symbol, this.blockExplorerUrl);
}