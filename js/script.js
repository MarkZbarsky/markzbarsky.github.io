document.addEventListener('DOMContentLoaded', function() {
  // Mobile menu toggle
  const hamburger = document.querySelector('.hamburger');
  const navLinks = document.querySelector('.nav-links');
  
  if (hamburger) {
      hamburger.addEventListener('click', function() {
          hamburger.classList.toggle('active');
          navLinks.classList.toggle('active');
          document.body.classList.toggle('menu-open');
      });
  }
  
  // Dropdown functionality for mobile
  const dropdownBtn = document.querySelector('.dropbtn');
  const dropdown = document.querySelector('.dropdown');
  
  if (dropdownBtn) {
      dropdownBtn.addEventListener('click', function(e) {
          if (window.innerWidth <= 768) {
              e.preventDefault();
              dropdown.classList.toggle('active');
          }
      });
  }
  
  // Close mobile menu when clicking on a link
  const navItems = document.querySelectorAll('.nav-links a:not(.dropbtn)');
  navItems.forEach(item => {
      item.addEventListener('click', function() {
          if (hamburger) hamburger.classList.remove('active');
          if (navLinks) navLinks.classList.remove('active');
          document.body.classList.remove('menu-open');
      });
  });
  
  // Add smooth scroll for anchor links
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
      anchor.addEventListener('click', function(e) {
          e.preventDefault();
          
          const targetId = this.getAttribute('href');
          if (targetId === '#') return;
          
          const targetElement = document.querySelector(targetId);
          if (targetElement) {
              window.scrollTo({
                  top: targetElement.offsetTop - 70,
                  behavior: 'smooth'
              });
          }
      });
  });
  
  // Add scroll animation for elements
  const animateOnScroll = function() {
      const elements = document.querySelectorAll('.project-card, .resume-section, .gallery-item, .process-step');
      
      elements.forEach(element => {
          const position = element.getBoundingClientRect().top;
          const windowHeight = window.innerHeight;
          
          if (position < windowHeight - 100) {
              element.classList.add('visible');
          }
      });
  };
  
  // Run animation on scroll
  window.addEventListener('scroll', animateOnScroll);
  
  // Run once on page load
  animateOnScroll();
  
  // Handle video playback on mobile
  const videos = document.querySelectorAll('video');
  videos.forEach(video => {
      video.addEventListener('loadstart', function() {
          this.muted = true; // Ensure videos can autoplay on mobile
      });
  });
});
