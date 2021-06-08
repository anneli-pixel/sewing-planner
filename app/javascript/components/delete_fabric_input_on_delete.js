const deleteFabricInputOnDelete = () => {
  const pageId = document.querySelector('body').children[1].id;
  const pageIdsWithDeleteFabricButtons = ['projects-edit', 'projects-new', 'projects-create', 'projects-update'];

  if (pageIdsWithDeleteFabricButtons.includes(pageId)) {
    const fabricInputAndDeleteFields = document.querySelectorAll('.flex-box-input-and-delete');

    fabricInputAndDeleteFields.forEach((field) => {
      const deleteIcon = field.lastElementChild;
      deleteIcon.addEventListener('click', () => {
        const inputField = field.firstElementChild.firstElementChild;
        if (inputField.value === '') {
          inputField.value = inputField.defaultValue;
        } else {
          inputField.value = '';
        }
      });
    });
  }
}

export { deleteFabricInputOnDelete };
