import * as THREE from 'three';
import { createMoon } from './lights/moon.js';

export function createLights() {
  const ambientLight = new THREE.AmbientLight(0x404040, 0.5);
  const { directionalLight, moonMesh } = createMoon();
  
  // Position the moon group independently
  moonMesh.position.set(20, 50, 15.5);

  return [
    ambientLight,
    directionalLight,
    moonMesh
  ];
}
