{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Web
    grpcui # postman for grpc
    grpcurl # curl for grpc
    httpie # better curl
    prettyping # better "ping"
    kubectx
    kubectl
  ];
}
