import { Controller } from "@hotwired/stimulus";
import * as THREE from 'three';
import { createScene } from '../lib/threejs/scene.js';
import { createCamera } from '../lib/threejs/camera.js';
import { createRenderer } from '../lib/threejs/renderer.js';
import { createControls } from '../lib/threejs/controls.js';

export default class extends Controller {
  connect() {
    this.scene = createScene();
    this.camera = createCamera();
    this.renderer = createRenderer(this.element);
    this.controls = createControls(this.camera, this.renderer);

    this.addCube();
    this.animate();
  }

  // A dedicated method to create and add the cube
  addCube() {
    const geometry = new THREE.BoxGeometry(1, 1, 1);
    const material = new THREE.MeshBasicMaterial({ color: 0x00ff00 }); 
    const cube = new THREE.Mesh(geometry, material);
    this.scene.add(cube);
  }

  animate() {
    requestAnimationFrame(this.animate.bind(this));
    this.controls.update();
    this.renderer.render(this.scene, this.camera);
  }
}
