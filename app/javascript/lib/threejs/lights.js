import * as THREE from 'three';
import { createSun } from './lights/sun.js';

export function createLights() {
  const ambientLight = new THREE.AmbientLight(0xffffff, 0.5);
  const { directionalLight, sunMesh } = createSun();
  
  return [
    ambientLight,
    directionalLight,
    sunMesh,
  ];
}
