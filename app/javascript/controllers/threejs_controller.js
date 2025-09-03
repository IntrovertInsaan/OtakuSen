import { Controller } from "@hotwired/stimulus";
import * as THREE from 'three';
import { createScene } from '../lib/threejs/scene.js';
import { createCamera } from '../lib/threejs/camera.js';
import { createRenderer } from '../lib/threejs/renderer.js';
import { createHelpers } from '../lib/threejs/helpers.js';
import { createPointerLockControls, updateMovement } from '../lib/threejs/controls/pointerlock.js';

export default class extends Controller {
  connect() {
    this.scene = createScene();
    this.camera = createCamera();
    this.renderer = createRenderer(this.element);

    // Add helpers to the scene
    const { gridHelper } = createHelpers();
    this.scene.add(gridHelper);
    
    // Add PointerLockControls
    this.controls = createPointerLockControls(this.camera, this.element);

    this.clock = new THREE.Clock();

    this.animate();
  }
  
  animate() {
    requestAnimationFrame(this.animate.bind(this));
    
    const delta = this.clock.getDelta();
    updateMovement(delta);
    
    this.renderer.render(this.scene, this.camera);
  }
}
