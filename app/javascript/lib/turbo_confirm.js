import Swal from "sweetalert2"

// Override the built-in Turbo confirm dialog
Turbo.setConfirmMethod((message, element) => {
    return new Promise((resolve) => {
        Swal.fire({
            title: 'Are you sure?',
            text: message || "This action cannot be undone!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#6b7280',
            confirmButtonText: 'Yes, delete it!',
            cancelButtonText: 'Cancel'
        }).then((result) => {
            resolve(result.isConfirmed)
        })
    })
})
