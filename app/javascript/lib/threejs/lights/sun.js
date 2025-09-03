import * as THREE from 'three';
import { createSphere } from '../objects.js';

export function createSun() {
  const directionalLight = new THREE.DirectionalLight(0xffffff, 20);
  directionalLight.position.set(20, 30, 15.5);
  directionalLight.castShadow = true;
  
  // Shadow map properties
  directionalLight.shadow.mapSize.width = 1024;
  directionalLight.shadow.mapSize.height = 1024;
  directionalLight.shadow.camera.near = 0.5;
  directionalLight.shadow.camera.far = 100;
  directionalLight.shadow.camera.left = -50;
  directionalLight.shadow.camera.right = 50;
  directionalLight.shadow.camera.top = 50;
  directionalLight.shadow.camera.bottom = -50;

  // Visible sun mesh
  const sunMesh = new THREE.Mesh(
    new THREE.SphereGeometry(2, 16, 16),
    new THREE.MeshBasicMaterial({ color: 0xffff00 })
  );
  sunMesh.position.copy(directionalLight.position);

  return { directionalLight, sunMesh };
}
