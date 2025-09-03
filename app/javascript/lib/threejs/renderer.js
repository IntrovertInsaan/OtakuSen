import * as THREE from 'three';

export function createRenderer(element) {
  const renderer = new THREE.WebGLRenderer({ alpha: true });
  renderer.setSize(window.innerWidth, window.innerHeight);
  element.appendChild(renderer.domElement);
  return renderer;
}
