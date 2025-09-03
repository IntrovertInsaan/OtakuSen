import * as THREE from 'three';
import { PointerLockControls } from 'three/addons/controls/PointerLockControls.js';

// Private module-level variables to hold the state
let controls;
const velocity = new THREE.Vector3();
const direction = new THREE.Vector3();
const keys = { w: false, a: false, s: false, d: false, shift: false };

// A private function to set up event listeners
function setupKeyListeners() {
  document.addEventListener('keydown', (event) => {
    switch (event.code) {
      case 'KeyW': keys.w = true; break;
      case 'KeyA': keys.a = true; break;
      case 'KeyS': keys.s = true; break;
      case 'KeyD': keys.d = true; break;
    }
  });

  document.addEventListener('keyup', (event) => {
    switch (event.code) {
      case 'KeyW': keys.w = false; break;
      case 'KeyA': keys.a = false; break;
      case 'KeyS': keys.s = false; break;
      case 'KeyD': keys.d = false; break;
    }
  });
}

export function createPointerLockControls(camera, element) {
  controls = new PointerLockControls(camera, element);
  element.addEventListener('click', () => {
    controls.lock();
  });
  // Setup listeners once the controls are created
  setupKeyListeners();
  return controls;
}

export function updateMovement(delta) {
  if (controls && controls.isLocked) {
    direction.z = Number(keys.w) - Number(keys.s);
    direction.x = Number(keys.d) - Number(keys.a);
    direction.normalize();

    velocity.x -= direction.x * 500 * delta;
    velocity.z -= direction.z * 500 * delta;

    controls.moveRight(-velocity.x * delta);
    controls.moveForward(-velocity.z * delta);

    velocity.x *= 0.9;
    velocity.z *= 0.9;
  }
}
