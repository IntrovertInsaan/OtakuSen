import { Controller } from "@hotwired/stimulus";
import * as THREE from 'three';
import { createScene } from '../lib/threejs/scene.js';
import { createCamera } from '../lib/threejs/camera.js';
import { createRenderer } from '../lib/threejs/renderer.js';
import { createHelpers } from '../lib/threejs/helpers.js';
import { createPointerLockControls, updateMovement } from '../lib/threejs/controls/pointerlock.js';
import { createLights } from '../lib/threejs/lights.js';
import { createBox, createPlane } from '../lib/threejs/objects.js';

export default class extends Controller {
  connect() {
    this.scene = createScene();
    this.camera = createCamera();
    this.renderer = createRenderer(this.element);

    const { gridHelper } = createHelpers();
    this.scene.add(gridHelper);

    const lights = createLights();
    lights.forEach(light => this.scene.add(light));
    
    // Create and add customized objects to the scene
    const plane = createPlane({ color: 'lightgrey', width: 200, height: 200 });
    this.scene.add(plane);
    
    const box1 = createBox({ color: 'green', size: 10 });
    box1.position.y = 5;
    this.scene.add(box1);
    
    const box2 = createBox({ color: 'red', size: 5 });
    box2.position.set(15, 2.5, 0);
    this.scene.add(box2);

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
