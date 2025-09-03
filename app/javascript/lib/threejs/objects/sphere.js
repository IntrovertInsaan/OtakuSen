import * as THREE from 'three';

export function createSphere(options = {}) {
  const { color = 'orange', radius = 2 } = options;
  const geometry = new THREE.SphereGeometry(radius, 32, 32);
  const material = new THREE.MeshStandardMaterial({ color });
  const mesh = new THREE.Mesh(geometry, material);
  mesh.castShadow = true;
  mesh.receiveShadow = true;
  return mesh;
}
