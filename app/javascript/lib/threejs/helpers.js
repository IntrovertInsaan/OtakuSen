import * as THREE from 'three';

export function createHelpers() {
  const gridHelper = new THREE.GridHelper(200, 200);
  // const axesHelper = new THREE.AxesHelper(5);

  return { gridHelper };
}
