#!/bin/bash
set -e

# -------------------------
# CONFIGURATION
# -------------------------
REGISTRY="marouanedbibih"   # ✅ your DockerHub or GitLab registry
TAG="latest"                # you can make this dynamic with: TAG=$(date +%Y%m%d%H%M)

# -------------------------
# SERVICES to build
# -------------------------
ALL_SERVICES=("eureka" "gateway" "car-service" "client-service" "web")

# -------------------------
# FUNCTIONS
# -------------------------
build_and_push() {
  local SERVICE=$1

  case $SERVICE in
    eureka)
      CONTEXT="eureka/"
      DOCKERFILE="Dockerfile"
      ;;
    gateway)
      CONTEXT="gateway/"
      DOCKERFILE="Dockerfile"
      ;;
    car-service)
      CONTEXT="car/"
      DOCKERFILE="Dockerfile"
      ;;
    client-service)
      CONTEXT="client/"
      DOCKERFILE="Dockerfile"
      ;;
    web)
      CONTEXT="web/"
      DOCKERFILE="Dockerfile"
      ;;
    *)
      echo "❌ Unknown service: $SERVICE"
      exit 1
      ;;
  esac

  IMAGE_NAME="${REGISTRY}/${SERVICE}:${TAG}"

  echo "🚀 Building image for ${SERVICE}..."
  docker build --target prod -t "${IMAGE_NAME}" -f "${CONTEXT}/${DOCKERFILE}" "${CONTEXT}"

  echo "📤 Pushing ${IMAGE_NAME} to registry..."
  docker push "${IMAGE_NAME}"

  echo "✅ Done with ${SERVICE}."
}

# -------------------------
# MAIN LOGIC
# -------------------------
if [ "$1" == "all" ] || [ -z "$1" ]; then
  echo "🔄 Building ALL services..."
  for SERVICE in "${ALL_SERVICES[@]}"; do
    build_and_push "$SERVICE"
  done
else
  echo "🎯 Building ONLY service: $1"
  build_and_push "$1"
fi

echo "🎉 Build process complete!"
