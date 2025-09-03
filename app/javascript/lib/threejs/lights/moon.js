import * as THREE from 'three';

export function createMoon() {
  const directionalLight = new THREE.DirectionalLight(0xc0c0c0, 5);
  directionalLight.position.set(20, 50, 15.5);
  directionalLight.castShadow = true;
  
  directionalLight.shadow.mapSize.width = 1024;
  directionalLight.shadow.mapSize.height = 1024;
  directionalLight.shadow.camera.near = 0.5;
  directionalLight.shadow.camera.far = 100;
  directionalLight.shadow.camera.left = -50;
  directionalLight.shadow.camera.right = 50;
  directionalLight.shadow.camera.top = 50;
  directionalLight.shadow.camera.bottom = -50;

  const moonGroup = new THREE.Group();
  
  const moon = new THREE.Mesh(
    new THREE.SphereGeometry(2, 32, 32),
    new THREE.MeshBasicMaterial({ color: 0xc0c0c0 })
  );
  moonGroup.add(moon);

  const occluder = new THREE.Mesh(
    new THREE.SphereGeometry(2, 32, 32),
    new THREE.MeshBasicMaterial({ color: 0x000000 })
  );
  
  // The occluder needs to be positioned at a larger distance from the moon's center
  // to create the crescent from a camera's perspective.
  occluder.position.set(2, 0, 0); 
  moonGroup.add(occluder);
  
  return { directionalLight, moonMesh: moonGroup };
}