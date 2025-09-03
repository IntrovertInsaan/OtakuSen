import * as THREE from 'three';

export function createPlane(options = {}) {
  const { color = 'lightgray', width = 100, height = 100 } = options;
  const geometry = new THREE.PlaneGeometry(width, height);
  const material = new THREE.MeshStandardMaterial({ color });
  const mesh = new THREE.Mesh(geometry, material);
  mesh.receiveShadow = true;
  mesh.rotation.x = -Math.PI / 2;
  return mesh;
}
